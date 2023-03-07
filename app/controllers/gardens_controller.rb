class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @unique_plants = @garden.uniq_plants
  end
end