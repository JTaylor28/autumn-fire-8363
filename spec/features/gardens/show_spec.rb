require 'rails_helper'

RSpec.describe "/gardens/:id", type: :feature do
  before :each do
    @garden = Garden.create(name: "My Garden", organic: true)

    @plot1 = @garden.plots.create!(number: 1, size: "large", direction: "North")
    @plot2 = @garden.plots.create!(number: 2, size: "large", direction: "South")
    @plot3 = @garden.plots.create!(number: 3, size: "small", direction: "West")
    @plot4 = @garden.plots.create!(number: 4, size: "small", direction: "East")
    
    @plant1 = Plant.create!(name: "Blue plant", description: "its a blue plant", days_to_harvest: 30)
    PlantPlot.create!(plot: @plot1, plant: @plant1)
    PlantPlot.create!(plot: @plot2, plant: @plant1)
    @plant2 = Plant.create!(name: "Red plant", description: "its a red plant", days_to_harvest: 80)
    PlantPlot.create!(plot: @plot1, plant: @plant2)
    PlantPlot.create!(plot: @plot2, plant: @plant2)
    PlantPlot.create!(plot: @plot3, plant: @plant2)
    PlantPlot.create!(plot: @plot4, plant: @plant2)

    @plant3 = Plant.create!(name: "Green plant", description: "its a green plant", days_to_harvest: 101)
    PlantPlot.create!(plot: @plot1, plant: @plant3)
    
    @plant4 = Plant.create!(name: "Yello plant", description: "its a yellow plant", days_to_harvest: 70)
    PlantPlot.create!(plot: @plot1, plant: @plant4)


    
    
    visit "/gardens/#{@garden.id}"
  end

  describe "As a visitor, When I visit the gardens show page" do
    it "I see a unique list of plants that take less than 100 days to harvest " do
      expect(page).to have_content("#{@garden.name}'s Show Page")
      expect(page).to have_content("plants that take less than 100 days to harvest")
      expect(page).to have_content("#{@plant1.name}", count: 1)
      expect(page).to have_content("#{@plant2.name}", count: 1)
      expect(page).to have_content("#{@plant4.name}", count: 1)

      expect(page).to_not have_content("#{@plant3.name}")
    end
  end
end