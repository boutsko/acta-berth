# coding: utf-8
module TugOrder

  def tug_order

    template = self
    foo = @quest.vess
    @output_file = ".#{foo._name.gsub(/  */, "_")}_tug_order.pdf"

    template_dir = Foobar::Utils.gem_libdir + '/templates/'
    filename = "#{template_dir}flot_zayavka.pdf"

    Prawn::Document.generate(@output_file, :template => filename) do
      go_to_page(page_count)

      font "#{template_dir}arialbi.ttf"
      text_box "#{foo._name}",                   :at => [53, 630], :width => 70, :size => 10
      text_box "#{foo._flag}",                   :at => [210, 630], :width => 70, :size => 10
      text_box "#{foo._loa} ",                   :at => [53, 568], :width => 70, :size => 10
      text_box "#{foo._beam}",                   :at => [130, 568], :width => 70, :size => 10
      text_box "#{foo._mdepth}",                 :at => [210, 568], :width => 70, :size => 10
      text_box "#{foo._gt}",                     :at => [285, 568], :width => 70, :size => 10
      #      cargo_grade = "сырая нефть"
      text_box "#{template.cargo_grade}",             :at => [340, 578], :width => 70, :size => 8
      #  text_box "#{template.cargo_quantity} mt", :at => [340, 568], :width => 70, :size => 10
      text_box "#{template.cargo_quantity} mt",       :at => [340, 568], :width => 70, :size => 10
      text_box "#{foo._owner}",                  :at => [263, 540], :width => 120, :size => 10 
      #      date_of_arrival = '11/12/15:00'
      text_box "#{template.arrival_dtime}",         :at => [53, 530], :width => 100, :size => 10
      #      days_in_port = '3'
      text_box "#{template.days_in_port}",            :at => [200, 530], :width => 100, :size => 10

      berth = { 
        "shs" => "Шесхарис",
        "ipp" =>  "НМТП",
        "s" => "Шесхарис",
        "i" =>  "НМТП"
      }

      if template.berth =~ /^\w+\d\d?/
        if template.munmur =~ /^m/
          template.berth.sub(/(.*?)(\d\d?)/) do
            text_box "#{$2}", :at => [220, 359], :width => 70, :size => 10
            text_box "#{berth[$1]}", :at => [250, 359], :width => 70, :size => 10 
          end
          text_box "Швартовка", :at => [53, 359], :width => 70, :size => 10 
        elsif template.munmur =~ /^u/
          template.berth.sub(/(.*?)(\d\d?)/) do
            text_box "#{$2}", :at => [140, 359], :width => 70, :size => 10
            text_box "#{berth[$1]}", :at => [170, 359], :width => 70, :size => 10 
          end
          text_box "Отшвартовка", :at => [53, 359], :width => 70, :size => 9
        elsif template.munmur =~ /^b/
          template.berth.sub(/(.*?)(\d\d?)/) do
            text_box "#{$2}", :at => [220, 359], :width => 70, :size => 10
            text_box "#{berth[$1]}", :at => [250, 359], :width => 70, :size => 10 
          end
          text_box "Постановка бонов", :at => [53, 359], :width => 70, :size => 10
        end
      end

      text_box "#{template.berthing_dtime.gsub(/\/(\d+:\d+)$/, "")}/13", :at => [308, 359], :width => 70, :size => 9
      text_box "#{$1}", :at => [308, 339], :width => 70, :size => 9
      text_box "Иванов Петр", :at => [83, 159], :width => 130, :size => 11
      text_box "тел : +79887777777", :at => [83, 135], :width => 130, :size => 11
      
    end

    see_pdf
    
  end

end
