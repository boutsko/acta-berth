# coding: utf-8
module PilotOrder

  def pilot_order

    template = self
    foo = @quest.vess
    @output_file = ".#{foo._name.gsub(/  */, "_")}_pilot_order.pdf"
    template_dir = Foobar::Utils.gem_libdir + '/templates/'
    filename = "#{template_dir}pilot_zayavka.pdf"
    Prawn::Document.generate(@output_file, :template => filename) do
      go_to_page(page_count)
      
      font "#{template_dir}arialbi.ttf"
      text_box "#{foo._name}",                   :at => [120, 534], :width => 200, :size => 10
      text_box "#{foo._flag}",                   :at => [330, 534], :width => 70, :size => 10
      text_box "#{foo._loa} ",                   :at => [120, 510], :width => 70, :size => 10
      text_box "#{foo._beam}",                   :at => [280, 510], :width => 70, :size => 10
      text_box "#{foo._mdepth}",                 :at => [430, 510], :width => 70, :size => 10
      text_box "#{foo._gt}",                     :at => [120, 480], :width => 70, :size => 10
      text_box "#{foo._nrt}",                     :at => [120, 450], :width => 70, :size => 10

      berth = { 
        "shs" => "Шесхарис",
        "ipp" =>  "НМТП",
        "s" => "Шесхарис",
        "i" =>  "НМТП"
      }


      if template.berth =~ /^\w+\d\d?/
        if template.munmur =~ /^m/
          text_box "X", :at => [140, 379], :width => 70, :size => 10 
          text_box "#{template.berthing_dtime.gsub(/\/(\d+:\d+)$/, "")}/13", :at => [410, 379], :width => 70, :size => 9
          text_box "#{$1}", :at => [460, 379], :width => 70, :size => 9
          template.berth.sub(/(.*?)(\d\d?)/) do
            text_box "#{$2}", :at => [305, 379], :width => 70, :size => 10
            text_box "#{berth[$1]}", :at => [345, 379], :width => 70, :size => 10 
            text_box "#{foo._draft_arrival_fore}", :at => [340, 480], :width => 70, :size => 10
            text_box "#{foo._draft_arrival_aft}", :at => [430, 480], :width => 70, :size => 10
          end
        elsif template.munmur =~ /^u/
          text_box "X", :at => [140, 359], :width => 70, :size => 10 
          text_box "#{template.berthing_dtime.gsub(/\/(\d+:\d+)$/, "")}/13", :at => [410, 359], :width => 70, :size => 9
          text_box "#{$1}", :at => [460, 359], :width => 70, :size => 9
          template.berth.sub(/(.*?)(\d\d?)/) do
            text_box "#{$2}", :at => [305, 359], :width => 70, :size => 10
            text_box "#{berth[$1]}", :at => [345, 359], :width => 70, :size => 10 
            text_box "#{foo._draft_departure}", :at => [340, 480], :width => 70, :size => 10
            text_box "#{foo._draft_departure}", :at => [430, 480], :width => 70, :size => 10
            text_box "#{template.cargo_grade}", :at => [430, 450], :width => 70, :size => 10
            text_box "#{template.cargo_quantity} mt", :at => [340, 450], :width => 70, :size => 10
          end
        end
      end

      text_box "Иванов Петр", :at => [145, 159], :width => 130, :size => 11
      text_box "тел : +79887777777", :at => [145, 145], :width => 130, :size => 11
      
    end

    see_pdf

  end

end
