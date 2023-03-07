class PlantPlotsController < ApplicationController
  def destroy
    plant_plot = PlantPlot.find_by(plot_id: params[:plot_id], plant_id: params[:id])
    plant_plot.destroy
    redirect_to "/plots"
  end
end