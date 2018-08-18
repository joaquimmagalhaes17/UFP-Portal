require 'rest-client'
require 'nokogiri'

module ScrapperHelper
  def self.login(number, password)
    response = RestClient.get 'https://portal.ufp.pt/authentication.aspx'
    doc = Nokogiri::HTML(response.body)

    view_state = doc.xpath('//*[@id="__VIEWSTATE"]').map { |node| node["value"] }.first
    view_state_generator = doc.xpath('//*[@id="__VIEWSTATEGENERATOR"]').map { |node| node["value"] }.first
    event_validation = doc.xpath('//*[@id="__EVENTVALIDATION"]').map { |node| node["value"] }.first

    data = {
      '__EVENTTARGET': '',
      '__EVENTARGUMENT': '',
      '__VIEWSTATE': view_state,
      '__VIEWSTATEGENERATOR': view_state_generator,
      '__EVENTVALIDATION': event_validation,
      'ctl00$ContentPlaceHolder1$Accordion1_AccordionExtender_ClientState': '0',
      'ctl00$ContentPlaceHolder1$AccordionPane1_content$txtLogin': number,
      'ctl00$ContentPlaceHolder1$AccordionPane1_content$Button1': 'Validar',
      'ctl00$ContentPlaceHolder1$AccordionPane1_content$txtPassword': password,
      'ctl00$ContentPlaceHolder1$AccordionPane1_content$ddlIMG': 'pt',
    }

    response = RestClient.post('https://portal.ufp.pt/authentication.aspx', data) { |res, _, _, &block|
      if [301, 302, 307].include? res.code
        res.follow_redirection(&block)
      else
        res.return!(&block)
      end
    }

    response.cookies
  end

  def self.definitive_recent_grades(cookies)
    response = RestClient.get('https://portal.ufp.pt/Notas/Recente.aspx', cookies: cookies)
    doc = Nokogiri::HTML(response.body)

    grades = Array.new
    first = true

    doc.css('table#ctl00_ContentPlaceHolder1_AccordionPane1_content_GridView1 tr').each do |abc|
      unless first
        grades << {
          curricular_unit: abc.css('td')[0].inner_text,
          course: abc.css('td')[1].inner_text,
          grade: abc.css('td')[2].inner_text,
          release_date: abc.css('td')[3].inner_text,
          year: abc.css('td')[4].inner_text,
          consultation_date: abc.css('td')[5].inner_text,
          oral: abc.css('td')[6].inner_text
        }
      end
      first = false
    end
    grades
  end
end
