module Api::ExamsHelper
  def self.parse(information)
    return [] if information == []

    data = []

    information.each do |entry|
      data << {
          unit: entry['Disciplina'],
          course: entry['Curso'],
          type: entry['Tipologia'],
          date: entry['Data'],
          year: entry['AnoLectivo'],
          room: entry['Sala'],
          teachers: entry['Responsavel'].split('<br>')
      }
    end

    data
  end
end
