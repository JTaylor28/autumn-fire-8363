require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plant_plots).through(:plots) }
    it { should have_many(:plants).through(:plant_plots) }
  end
  before :each do
    @garden = Garden.create(name: "My Garden", organic: true)

    @plot1 = @garden.plots.create!(number: 1, size: "large", direction: "North")
    @plot2 = @garden.plots.create!(number: 2, size: "large", direction: "South")
    
    @plant1 = Plant.create!(name: "Blue plant", description: "its a blue plant", days_to_harvest: 90)
    PlantPlot.create!(plot: @plot1, plant: @plant1)
    PlantPlot.create!(plot: @plot2, plant: @plant1)
  
    @plant2 = Plant.create!(name: "Red plant", description: "its a red plant", days_to_harvest: 80)
    PlantPlot.create!(plot: @plot1, plant: @plant2)
    PlantPlot.create!(plot: @plot2, plant: @plant2)

    @plant3 = Plant.create!(name: "Green plant", description: "its a green plant", days_to_harvest: 101)
    PlantPlot.create!(plot: @plot1, plant: @plant3)
    
  end

  describe "instance methods" do
    it "#uniq_passengers_list" do
      expect(@garden.uniq_plants).to eq([@plant1, @plant2, @plant3])
    end
  end
end
