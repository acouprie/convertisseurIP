require 'gtk2'

Gtk.init

# Initialize window
window = Gtk::Window.new
window.set_title('Convertisseur IP')
window.signal_connect('destroy') { Gtk.main_quit }
# IP address
ip_label_1 = Gtk::Label.new
ip_label_1.set_text("Entrez l'addresse IP :")
ip_address_1 = Gtk::Entry.new.set_text('192')
ip_address_2 = Gtk::Entry.new.set_text('168')
ip_address_3 = Gtk::Entry.new.set_text('0')
ip_address_4 = Gtk::Entry.new.set_text('1')
# Mask
mask_label_1 = Gtk::Label.new
mask_label_1.set_text("Entrez le masque de sous-réseau :")
mask_address_1 = Gtk::Entry.new.set_text('255')
mask_address_2 = Gtk::Entry.new.set_text('224')
mask_address_3 = Gtk::Entry.new.set_text('0')
mask_address_4 = Gtk::Entry.new.set_text('0')
# address
first_address_1 = 0
first_address_2 = 0
first_address_3 = 0
first_address_4 = 0
last_address_1 = 0
last_address_2 = 0
last_address_3 = 0
last_address_4 = 0

comps_1 = 1
comps_2 = 1
comps_3 = 1
comps_4 = 1
# Submit button
submit = Gtk::Button.new(Gtk::Stock::OK)
submit.signal_connect('clicked') {
  ip_1 = ip_address_1.text.to_i
  ip_2 = ip_address_2.text.to_i
  ip_3 = ip_address_3.text.to_i
  ip_4 = ip_address_4.text.to_i

  mask_1 = mask_address_1.text.to_i
  mask_2 = mask_address_2.text.to_i
  mask_3 = mask_address_3.text.to_i
  mask_4 = mask_address_4.text.to_i

  if mask_1 == 255
    first_address_1 = ip_1
    last_address_1 = ip_1
  else
    magic_number = 256-mask_1
    i = 0
    j = 0
    begin
      while j < (ip_1 - magic_number)
        j += magic_number
        first_address_1 = j
      end
      i += magic_number
      last_address_1 = i - 1
    end while i < ip_1
  end

  if mask_2 == 255
     first_address_2 = ip_2
     last_address_2 = ip_2
  else
    magic_number = 256-mask_2
    i = 0
    j = 0
    begin
      while j < (ip_2 - magic_number)
        j += magic_number
        first_address_2 = j
      end
      i += magic_number
      last_address_2 = i - 1
    end while i < ip_2
  end

  if mask_3 == 255
    first_address_3 = ip_3
    last_address_3 = ip_3
  else
    magic_number = 256-mask_3
    i = 0
    j = 0
    begin
      while j < (ip_3 - magic_number)
        j += magic_number
        first_address_3 = j
      end
      i += magic_number
      last_address_3 = i - 1
    end while i < ip_3
  end

  magic_number = 256-mask_4
  i = 0
  j = 0
  begin
    print " #{i} "
    while j < (ip_4 - magic_number)
      print " #{j} "
      j += magic_number
      first_address_4 = j
    end
    i += magic_number
    last_address_4 = i - 1
  end while i < ip_4

  comps_4 = last_address_4 - first_address_4
  if last_address_3 != first_address_3
    comps_3 = last_address_3 - first_address_3
  end
  if last_address_2 != first_address_2
    comps_2 = last_address_2 - first_address_2
  end
  if last_address_1 != first_address_1
    comps_1 = last_address_1 - first_address_1
  end
  num_comps = comps_1 * comps_2 * comps_3 * comps_4

  # store important addresses
  network_address = Array.new
  brodcast_address = Array.new
  network_address.push(first_address_1, first_address_2, first_address_3, first_address_4)
  brodcast_address.push(last_address_1, last_address_2, last_address_3, last_address_4)

  # classes
  classe_a = "127.255.255.255"
  classe_b = "191.255.255.255"
  classe_c = "223.255.255.255"
  if network_address.join(".") < classe_a
    classe = 'A'
  elsif network_address.join(".") > classe_a && network_address.join(".") < classe_b
    classe = 'B'
  elsif network_address.join(".") > classe_b && network_address.join(".") < classe_c
    classe = 'C'
  else
    classe = "E ou D"
  end

  info = Gtk::MessageDialog.new(window, Gtk::Dialog::DESTROY_WITH_PARENT,
                             Gtk::MessageDialog::INFO,
                             Gtk::MessageDialog::BUTTONS_CLOSE,
                             "Adresse du réseau : #{network_address.join(".")} \n"\
                             "Adresse  broadcast du réseau : #{brodcast_address.join(".")} \n"\
                             "Première adresse du réseau : #{network_address[0]}.#{network_address[1]}.#{network_address[2]}.#{network_address[3]+1} \n"\
                             "Dernière adresse du réseau : #{brodcast_address[0]}.#{brodcast_address[1]}.#{brodcast_address[2]}.#{brodcast_address[3]-1} \n"\
                             "Réseau de classe #{classe} \n"\
                             "Nombre de machines possible sur ce réseau : #{num_comps} \n")
  info.set_default_size(1000, 1000)
  info.run
  info.destroy
}
# Contain elements
ip_container = Gtk::HBox.new(false, 6)
mask_container = Gtk::HBox.new(false, 6)
  # 4 textfields for IP address
ip_container.pack_start(ip_address_1)
ip_container.pack_start(ip_address_2)
ip_container.pack_start(ip_address_3)
ip_container.pack_start(ip_address_4)
  # 4 textfields for IP mask
mask_container.pack_start(mask_address_1)
mask_container.pack_start(mask_address_2)
mask_container.pack_start(mask_address_3)
mask_container.pack_start(mask_address_4)
  # Add them all in one container
main_container = Gtk::VBox.new(false, 6)
main_container.pack_start(ip_label_1)
main_container.pack_start(ip_container)
main_container.pack_start(mask_label_1)
main_container.pack_start(mask_container)
main_container.pack_start(submit)
# Setting up window
window.add(main_container)
window.show_all

Gtk.main
