class GpslocationsController < InheritedResources::Base

  private

    def gpslocation_params
      params.require(:gpslocation).permit(:name, :address, :latitude, :longitude)
    end
end

