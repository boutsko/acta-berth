# -*- coding: utf-8 -*-

module ShoreInfo

  def info_shs

    template_dir = Foobar::Utils.gem_libdir + '/templates/'
#    foo = @quest.vess

    output_file = ".#{_name.gsub(/  */, "_")}_info_shs.pdf"
    font "#{template_dir}arialbi.ttf"
    bounding_box([50, 700], :width => 500, :height => 700) do
      text "      Предварительная информация по прибывающему #{arrival_time}"
      text "      танкеру #{_name} / #{name_ru}"
      move_down 30
      text ""
      text "      Флаг : #{flag_ru}, Позывной : #{_call_sign}, ИМО Номер : #{_imo}"
      move_down 20
      text "      Длина : #{_loa} м, Ширина : #{_beam} м, Высота борта : #{_mdepth} м"
      move_down 20
      text "      Дедвейт : #{_dwt} мт, Максимальная осадка #{_sdraft} м"
      move_down 20
      text "      Осадка на прибытие : нос #{_draft_arrival_fore} м, корма #{_draft_arrival_aft} м"
      move_down 20
      text "      Сегрегированный балласт : #{_ballast} mt"
      move_down 20
      text "      возможность откатки балласта с обоих бортов : #{_ballast_both_sides}"
      move_down 20
      text "      количество груза : #{quantity} мт #{grade}"      
      move_down 20                                                                       
      text "      скорость погрузки : #{rate} мт"                           
      move_down 20                                                                       
      text "      кол-во манифолдов : #{manifold_number} "                          
      move_down 20                                                                       
      text "      скорость погрузки по одному манифолду #{rate_per_manifold} mts/hr"
      move_down 20
      text "      осадка на требуемое количество груза #{_draft_departure} м"
      move_down 20
      text "      количество бункера на приход FO/DO : #{_bunkers_on_arrival} мт"
      move_down 20
      text "      действие сертификата 
                    о гражданской ответственности : #{_clc_terms}"
      move_down 20
      text "      последний груз - #{_last_cargo}"
      move_down 20
      text ""
      move_down 20
      text "      содержание кислорода в инертном газе в грузовых танках -  менее 5%"
      move_down 20
      text ""
      move_down 20
      text "        С уважением"
      text "        #{APP_CONFIG[:agency][:name]}"
      text "      тел : #{APP_CONFIG[:agency][:phone]}"
      text ""
      move_down 10
      text "phone: #{APP_CONFIG[:agency][:phone]} | fax: #{APP_CONFIG[:agency][:phone]} | e-mail: #{APP_CONFIG[:agency][:email]}", :align => :center, :valign => :bottom
    end
    save_as(output_file)
    see_pdf
    
  end
  
  def info_ipp

    # foo = @quest.vess
    output_file = ".#{_name.gsub(/  */, "_")}_shore_info.pdf"
    template_dir = Foobar::Utils.gem_libdir + '/templates/'
    font "#{template_dir}arialbi.ttf"
    text "Название судна : #{_name} / #{name_ru}"
    text "Флаг : #{flag_ru}"
    move_down 20
    table([[{:content => "Время подхода : #{arrival_time}", :colspan => 3 }],
           [{:content => "Нотис о Готовности : сообщим дополнительно", :colspan => 3 }],
           [{:content => "Наименование и количество груза : около #{quantity} mt #{grade} ", :colspan => 3 }],
           ["Дедвейт : #{_dwt} mt",
            "Длина : #{_loa} m",
            "Водоизмещение : #{_displacement} mt"],
           [{:content => "Высота надводного борта в грузу : #{_freeboard_loaded}", :colspan => 2 },
            "Высота борта : #{_mdepth} m"], 
           [{:content =>"Осадка судна на приход : #{_draft_arrival_fore}/#{_draft_arrival_aft} m", :colspan => 2},
            {:content => "на отход : #{_draft_departure} m"}],
           [{:content => "Наличие грузоподъемных средств в районе судовых грузовых приемников : ", :colspan => 3 }],
           ["количество : #{_derrick_quantity} ",
            "грузоподъемность : #{_derrick_lift_power} t",
            "вылет стрелы за борт : #{_derrick_overhang} m"],
           [{:content => "Наличие системы инертных газов : Да", :colspan => 3 }],
           [{:content => "Содержание кислорода в грузовых танках : Менее 5%", :colspan => 3 }],
           [{:content => "Высота судовых грузовых приемников от уровня воды :", :colspan => 3 }],
           ["на приход : #{_distance_manifold_waterlevel_arrival} m",
            "на отход : #{_distance_manifold_waterlevel_departure} m"],
           [{:content => "Сведения о судовых грузовых приемниках :", :colspan => 2 }, "количество : #{manifold_number}",],
           [
             "диаметр : #{_manifold_diameter} ''",
             "материал : #{_manifold_material} ",              
             "тощина фланцев : #{_manifold_flange_thikness} mm " ],
           [{:content => "расстояние от борта до судовых приемников : #{_distance_rail_manifold} m", :colspan => 3 }],
           [{:content => "расстояние между судовыми приемниками : #{_distance_between_manifold} m", :colspan => 3 }],
           [{:content => "расстояние между палубой и судовыми приемниками : #{_distance_deck_manifold} m", :colspan => 3 }],
           [{:content => "Наличие и сведения о транзитных грузах : N/a", :colspan => 3 }],
           [{:content => "Потребность в бункеровке и удалении с борта бытовых отходов : N/a", :colspan => 3 }],
           [{:content => "Возможность слива сегрегированного балласта с обеих бортов : #{_ballast_both_sides}", :colspan => 3 }]
          ]) do |t|
      t.cells.border_width = 0
      t.before_rendering_page do |page|
        page.row(0).border_top_width = 1
        page.row(-1).border_bottom_width = 1
        page.row(2).border_bottom_width = 1
        page.row(5).border_bottom_width = 1
        page.row(7).border_bottom_width = 1
        page.row(9).border_bottom_width = 1
        page.row(16).border_bottom_width = 1
      end
    end

    move_down 20
    text "        С уважением"
    text "        #{APP_CONFIG[:agency][:name]}"
    text "      тел : #{APP_CONFIG[:agency][:phone]}"
    text ""
    move_down 10
    text "phone: #{APP_CONFIG[:agency][:phone]} | fax: #{APP_CONFIG[:agency][:phone]} | e-mail: #{APP_CONFIG[:agency][:email]}", :align => :center, :valign => :bottom
    save_as(output_file)
    see_pdf

  end

end
