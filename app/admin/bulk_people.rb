ActiveAdmin.register_page "Bulk People" do
  page_action :merge, method: :post do
    people = params['staff'].split(',')
    people = people.collect { |p| p.strip }.select { |p| p != '' }

    already_in = Person.where("name IN (?) and position_id = 20 and current = false", people)
    already_in.each do |person|
      person.update(current: true)
    end

    not_in = Person.where("name NOT IN (?) AND position_id = 20 and current = true", people)
    not_in.each do |person|
      person.update(current: false)
    end

    redirect_to admin_people_path, notice: "People merged"
  end

  content do
    para 'Upload a newline-delimited list of people to merge into the staff writers. All staff not in this list will be marked inactive!'
    form action: "bulk_people/merge", method: :post do |f|
      f.input :name => 'authenticity_token', :type => :hidden, :value => form_authenticity_token.to_s
      f.input :staff, type: :text, name: 'staff'
      f.input :submit, type: :submit
    end
  end
end
