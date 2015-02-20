require 'rails_helper'
require 'capybara/rails'

feature 'Users' do

  scenario "user can click on user name as a link and takes them to user show" do
    create_user email: "user@example.com"
    person = create_person

    visit '/'
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on person.full_name
    within 'h1' do
      expect(page).to have_content(person.full_name)
    end
  end

  scenario "user can edit people" do
    create_user email: "user@example.com"
    person = create_person

    visit '/'
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on person.full_name
    click_on "Edit"
    fill_in 'Title', with: "Doctor"
    fill_in "First Name", with: "Funken"
    fill_in "Last Name", with: "Stein"
    click_on "Update User"
    within '.table' do
      expect(page).to have_content("Doctor Funken Stein")
    end
  end
  scenario "user has to enter first/last or title/last when create" do
    create_user email: "user@example.com"
    person = create_person

    visit '/'
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on person.full_name
    click_on "Edit"
    fill_in 'Title', with: ""
    fill_in "First Name", with: ""
    fill_in "Last Name", with: "Stein"
    click_on "Update User"

    expect(page).to have_content("Title or first name must be entered")
  end

end
