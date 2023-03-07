require 'rails_helper'

RSpec.describe "/Plots", type: :feature do
  before :each do
    @garden = Garden.create(name: "My Garden", organic: true)

    @plot1 = @garden.plots.create!(number: 1, size: "large", direction: "North")
    @plot2 = @garden.plots.create!(number: 2, size: "large", direction: "South")
    @plot3 = @garden.plots.create!(number: 3, size: "small", direction: "West")

    @plant1 = Plant.create!(name: "Blue plant", description: "its a blue plant")
    @plant2 = Plant.create!(name: "Red plant", description: "its a red plant")

    PlantPlot.create!(plot: @plot1, plant: @plant1)
    PlantPlot.create!(plot: @plot2, plant: @plant1)
    PlantPlot.create!(plot: @plot3, plant: @plant1)
    
    PlantPlot.create!(plot: @plot1, plant: @plant2)
    PlantPlot.create!(plot: @plot2, plant: @plant2)
    
    visit "/plots"
  end
  describe "As a visitor, when I visit the plots index page" do
    it " I see a list of all plot numbers" do
      save_and_open_page
      expect(page).to have_content("Plot ##{@plot1.number}")
      expect(page).to have_content("Plot ##{@plot2.number}")
      expect(page).to have_content("Plot ##{@plot3.number}")
    end
   
    it " And under each plot number I see the names of all that plot's plants" do
      expect(page).to have_content("Plants")
      expect(page).to have_content("#{@plant1.name}")
      expect(page).to have_content("#{@plant2.name}")
    end 

    it "next to each plant name, I see a button to remove that plant from that plot" do
      within "#plot_info-#{@plot1.id}" do
        expect(page).to have_button("Remove #{@plant1.name}")
        expect(page).to have_button("Remove #{@plant2.name}")
      end

      within "#plot_info-#{@plot3.id}" do
        expect(page).to have_button("Remove #{@plant1.name}")
        expect(page).to_not have_button("Remove #{@plant2.name}")
      end
    end

    it "click button, redirect to plots index page, dont see plants under that plot, but do see plants under other plots" do
      within "#plot_info-#{@plot1.id}" do
        expect(page).to have_content(@plant1.name)
        expect(page).to have_content(@plant2.name)
        click_button("Remove #{@plant1.name}")
      end

      expect(current_path).to eq("/plots")

      within "#plot_info-#{@plot1.id}" do
        expect(page).to have_content(@plant2.name)
        expect(page).to_not have_content(@plant1.name)
      end

      within "#plot_info-#{@plot2.id}" do
        expect(page).to have_content(@plant2.name)
      end

      within "#plot_info-#{@plot3.id}" do
        expect(page).to have_content(@plant1.name)
      end
    end
    
  end
end