# coding: utf-8
module Form

  def choose_form
    case wording
        
    when /A(\d+)?/ 
      subject = "Тема : \"#{name}\" - уточнение подхода"
      content = "Пожалуйста, примите к сведению, что данный танкер " <<
                "прибывает в Новороссийск #{$1.form_date}."

      create_pdf(subject, content)

    when /^c/ 
      subject = "Тема : \"#{name}\" - отмена рейса"
      content = "Пожалуйста, примите к сведению, что рейс данного танкера " <<
                "отменяется."

      create_pdf(subject, content)
      
    when /a(\d+)?/
      subject = "Тема : \"#{name}\" - прибытие"
      content = "Пожалуйста, примите к сведению, что данный танкер " <<
                "прибыл в Новороссийск #{$1.form_date}." <<
                "\n\nО подаче Нотиса о Готовности сообщим дополнительно."

      create_pdf(subject, content)

    when /n(\d+)?/
      subject = "Тема : \"#{name}\"- Нотис о Готовности к погрузке"
      content = "Пожалуйста, примите к сведению, что данный танкер подал " <<
                "Нотис о Готовности к погрузке #{$1.form_date}."

      create_pdf(subject, content)

    when /N(\d+)?/ # N == nor on arrival
      subject = "Тема : \"#{name}\"- прибытие и Нотис о Готовности"
      content = "Пожалуйста, примите к сведению, что данный танкер прибыл " <<
                "в Новороссийск и подал Нотис о Готовности к погрузке #{$1.form_date}."

      create_pdf(subject, content)

    when /^-?p(\d+)?/
      subject = "Тема : \"#{name}\"- назначение"
      content = "Пожалуйста, примите к сведению, что наша компания " <<
                "получила назначение на обслуживание m/t \"#{name}\" / \"#{name_ru}\", " <<
                "флаг #{flag_ru}, прибывающего в Новороссийск #{$1.form_date} " <<
                "под погрузку около #{quantity} мт #{grade}."

      create_pdf(subject, content)

    when /^-?q(\d+)?/
      subject = "Тема : \"#{name}\"- количество груза"
      content = "Пожалуйста, примите к сведению, что согласно последних " <<
                "инструкций данный танкер будет грузить около #{$1} " <<
                "мт #{grade} и с данным количеством снимется в рейс."

      create_pdf(subject, content)

    when /^-?r/
      subject = "Тема : \"#{name}\"- скорость погрузки"
      content = "Пожалуйста, примите к сведению, что капитан судна " <<
                "гарантирует поддержание средней скорости налива у причала № #{rate =~ /9/ ? 1 : 2} " <<
                "н/р \"Шесхарис\" не менее #{rate} тонн в час."

      create_pdf(subject, content)

    when /^-?t(\d+:\d+[mub]+\d\d?)?/
      m = $1.to_s.match /(\d+):(\d+)(\w)(\d\d?)/
      arrival_dtime, berthing_dtime, munmur, days_in_port  = m[1].form_date, m[2].form_date, m[3], m[4]

      tug_order

    when /^-?l(\d+:\d+[mu]+\d\d?)?/
      m = $1.to_s.match /(\d+):(\d+)(\w)(\d\d?)/
      arrival_dtime, berthing_dtime, munmur, days_in_port  = m[1].form_date, m[2].form_date, m[3], m[4]

      pilot_order

    when /^-?i(\w+)/
      case $1
      when "shs"
        info_shs
      when "ipp"
        info_ipp
      else
        puts "Please check terminal (shs or ipp)"
      end
    else puts "Please check arguments"

    end
  end
end
