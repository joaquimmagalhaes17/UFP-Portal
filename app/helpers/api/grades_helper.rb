# frozen_string_literal: true

module Api::GradesHelper
  def self.parse_partial_grades(partial_grades)
    grades = []
    years = []

    partial_grades.each do |grade|
      unless years.include? grade['AnoLectivo']
        grades << {
          year: grade['AnoLectivo'],
          grades: []
        }
        years << grade['AnoLectivo']
      end

      grades.each do |entry|
        inserted = false
        next unless entry[:year] == grade['AnoLectivo']
        entry[:grades].each do |grade_inserted|
          next unless grade_inserted[:curricular_unit] == grade['Unidade']
          grade_inserted[:grades] << {
            element: grade['Elemento'],
            grade: grade['Nota'],
            released_by: grade['Responsavel'],
            registration_date: grade['Registo']
          }
          inserted = true
        end
        next if inserted
        tmp = {
          curricular_unit: grade['Unidade'],
          grades: []
        }
        tmp[:grades] << {
          element: grade['Elemento'],
          grade: grade['Nota'],
          released_by: grade['Responsavel'],
          registration_date: grade['Registo']
        }
        entry[:grades] << tmp
      end
    end

    grades
  end

  def self.parse_partial_years(partial_grades)
    years = []
    partial_grades.each do |grade|
      unless years.include? grade['AnoLectivo']
        years << grade['AnoLectivo']
      end
    end

    years
  end

  def self.parse_partial_to_table(partial_grades, params)
    first = (Integer(params[:page]) - 1) * Integer(params[:per_page])
    year = params[:year]
    last = first + Integer(params[:per_page])

    grades = []

    counter = 0
    partial_grades.each do |grade|
      if grade['AnoLectivo'] == year
        if first <= counter && counter < last
          grades << {
            element: grade['Elemento'],
            grade: grade['Nota'],
            released_by: grade['Responsavel'],
            registration_date: grade['Registo'],
            curricular_unit: grade['Unidade']
          }
        end
        counter += 1
      end
    end

    counter -= 1

    total_pages = counter / Integer(params[:per_page])

    total_pages = if (counter % Integer(params[:per_page]) > 0) && (total_pages > 0)
                    Integer(total_pages) + 1
                  elsif total_pages > 0
                    Integer(total_pages)
                  end

    return {
      total: counter + 1,
      per_page: Integer(params[:per_page]),
      current_page: Integer(params[:page]),
      last_page: total_pages,
      next_page_url: if Integer(params[:page]) == total_pages || total_pages == 0 then
                       nil
                     else
                       true
                     end,
      prev_page_url: Integer(params[:page]) == 1 ? nil : true,
      from: first + 1,
      to: first + grades.count,
      data: grades
    }
  end

  def self.parse_historic_to_table(historic_grades, params)
    first = (Integer(params[:page]) - 1) * Integer(params[:per_page])
    last = first + Integer(params[:per_page])

    grades = []
    counter = 0

    historic_grades.each do |grade|
      if first <= counter && counter < last
        grades << {
          degree: grade['Grau'],
          course: grade['Curso'],
          curricular_unit: grade['Unidade'],
          grade: grade['Nota'],
          registration_date: grade['Registo']
        }
      end
      counter += 1
    end

    total_pages = historic_grades.count / Integer(params[:per_page])

    total_pages = if (historic_grades.count % Integer(params[:per_page]) > 0) && (total_pages > 0)
                    Integer(total_pages) + 1
                  elsif total_pages > 0
                    Integer(total_pages)
                  end

    return {
      total: historic_grades.count,
      per_page: Integer(params[:per_page]),
      current_page: Integer(params[:page]),
      last_page: total_pages,
      next_page_url: if Integer(params[:page]) == total_pages || total_pages == 0 then
                         nil
                       else
                         true
                       end,
      prev_page_url: Integer(params[:page]) == 1 ? nil : true,
      from: first + 1,
      to: first + grades.count,
      data: grades
    }
  end

  def self.parse_without_pagination(grades)
    {
      total: grades.count,
      per_page: grades.count,
      current_page: 0,
      last_page: 0,
      next_page_url: nil,
      prev_page_url: nil,
      from: 0,
      to: grades.count,
      data: grades
    }
  end

  def self.parse_historic_grades(historic_grades)
    grades = []

    historic_grades.each do |grade|
      grades << {
        degree: grade['Grau'],
        course: grade['Curso'],
        curricular_unit: grade['Unidade'],
        grade: grade['Nota'],
        registration_date: grade['Registo']
      }
    end

    grades
  end

  def self.parse_final_grades(final_grades)
    grades = []

    final_grades.each do |grade|
      grades << {
        year: grade['AnoLectivo'],
        final_grade: grade['Nota'],
        consultation_date: grade['Consulta'],
        oral_date: grade['Oral'],
        write_ex: grade['Exame'],
        oral_ex: grade['NotaOral'],
        released_by: grade['Responsavel'],
        date_registration: grade['Registo'],
        curricular_unit: grade['Unidade'],
        epoch: grade['Epoca']
      }
    end

    grades
  end
end
