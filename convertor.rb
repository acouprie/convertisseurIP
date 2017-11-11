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
  d = Gtk::MessageDialog.new(window, Gtk::Dialog::DESTROY_WITH_PARENT,
                             Gtk::MessageDialog::INFO,
                             Gtk::MessageDialog::BUTTONS_CLOSE,
                             "Première adresse du réseau : #{first_address_1}.#{first_address_2}.#{first_address_3}.#{first_address_4} "\
                             "Dernière adresse du réseau : #{last_address_1}.#{last_address_2}.#{last_address_3}.#{last_address_4} "\
                             "Nombre de machines possible sur ce réseau : #{num_comps}")
  d.run
  d.destroy
  first_address = "Première adresse du réseau : #{first_address_1}.#{first_address_2}.#{first_address_3}.#{first_address_4} "
  print first_address
  last_address = "Dernière adresse du réseau : #{last_address_1}.#{last_address_2}.#{last_address_3}.#{last_address_4} "
  print last_address
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
