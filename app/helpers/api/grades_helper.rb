# frozen_string_literal: true

module Api::GradesHelper
  def self.parse_partial_grades(partial_grades)
    grades = []

    partial_grades.each do |grade|
      get_grade_array(grades, grade['AnoLectivo'], grade['Unidade']) << {
          element: grade['Elemento'],
          grade: grade['Nota'],
          released_by: grade['Responsavel'],
          registration_date: grade['Registo']
      }
    end

    grades
  end

  def self.get_grade_array(grades, year, curricular_unit)
    grades.each do |entry|
      return get_unit_array(entry[:grades], curricular_unit) if entry[:year] == year
    end

    aux = {
      year: year,
      grades: [{
        curricular_unit: curricular_unit,
        grades: []
      }]
    }

    grades << aux
    aux[:grades]
  end

  def self.get_unit_array(year_grades, curricular_unit)
    year_grades.each do |entry|
      return entry[:grades] if entry[:curricular_unit] == curricular_unit
    end

    aux = {
      curricular_unit: curricular_unit,
      grades: []
    }

    year_grades << aux
    aux[:grades]
  end

  def self.parse_partial_years(partial_grades)
    years = []
    partial_grades.each do |grade|
      years << grade['AnoLectivo'] unless years.include? grade['AnoLectivo']
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

    {
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

    {
      total: historic_grades.count,
      per_page: Integer(params[:per_page]),
      current_page: Integer(params[:page]),
      last_page: total_pages,
      next_page_url: ((Integer(params[:page]) == total_pages || total_pages == 0) ? nil : true),
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
      degree = get_degree_object(grade['Grau'], grades)
      course = get_course_object(grade['Curso'], degree)

      course[:grades] << {
        curricular_unit: grade['Unidade'],
        grade: grade['Nota'],
        registration_date: grade['Registo']
      }
    end

    grades
  end

  def self.get_degree_object(degree, grades)
    grades.each do |entry|
      return entry if entry[:degree] == degree
    end

    aux = {
      degree: degree,
      courses: []
    }
    grades << aux
    aux
  end

  def self.get_course_object(course, degree)
    degree[:courses].each do |entry|
      return entry if entry[:course] == course
    end

    aux = {
      course: course,
      grades: []
    }
    degree[:courses] << aux
    aux
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
