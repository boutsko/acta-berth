# coding: utf-8
module CreatePdf

  def create_pdf(subject, content)

    puts "Кому : #{manager}"
    puts "Куда : \"#{where}\""
    puts "Номер факса : #{fax}"
    puts "Дата : #{Date.today.to_s.sub(/20(\d+)-(\d+)-(\d+)/){$3 + "/" + $2 + "/" + $1}}"
    puts "Исходящий № :"
    puts "Кол-во страниц : 1"
    puts "Копия для : #{fax =~ /^760/ ? "НМТП, 5-я Пристань" : ""}"
    puts
    puts subject
    puts "-" * 70
    puts content
    puts "-" * 70
    
    template_dir = Foobar::Utils.gem_libdir + '/templates/'



    #      start_new_page
    #      stroke_axis

    font "#{template_dir}arialbi.ttf"

    image "#{template_dir}company_logo.png", :position => 370, :vposition => 60
    move_down 20

    bounding_box([50, 700], :width => 300, :height => 150) do
      transparent(0.5) { stroke_bounds }
      move_down 10

      indent(10) do
        # binding.pry
        text "Кому : #{manager}"
        text "Куда : \"#{where}\""
        text "Номер факса : #{fax}"
        text "Дата : #{Date.today.to_s.sub(/20(\d+)-(\d+)-(\d+)/){$3 + "/" + $2 + "/" + $1}}"
        text "Исходящий № :"
        text "Кол-во страниц : 1"
        text "Копия для : #{fax =~ /^760/ ? "НМТП, 5-я Пристань" : ""}"

        move_down 10

        text subject
      end
    end
    move_down 5

    bounding_box([50, cursor], :width => 450, :height => 180) do
      transparent(0.5) { stroke_bounds }

      move_down 10
      indent(10) do
        text content

        move_down(20)

        text " С уважением,"
        text APP_CONFIG[:agency][:name] 
        move_down(10)
        text APP_CONFIG[:agency][:phone] 
      end
    end

    output_file = ".#{name.to_s.gsub(/  */, "_")}_#{self.wording}.pdf"
    save_as(output_file)

    see_pdf
    
  end
  
  def see_pdf
    return 0
    if self.is_mac?
      system("open #{@output_file}") 
    elsif
      system("evince #{@output_file}") 
    end
  end
end
