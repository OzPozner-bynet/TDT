# encoding : utf-8
class LocationsController < BeautifulController

  before_filter :load_location, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    session[:fields] ||= {}
    session[:fields][:location] ||= (Location.columns.map(&:name) - ["id"])[0..4]
    do_select_fields(:location)
    do_sort_and_paginate(:location)
    
    @q = Location.search(
      params[:q]
    )

    @location_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @location_scope_for_scope = @location_scope.dup
    
    unless params[:scope].blank?
      @location_scope = @location_scope.send(params[:scope])
    end
    
    @locations = @location_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).all

    respond_to do |format|
      format.html{
        if request.headers['X-PJAX']
          render :layout => false
        else
          render
        end
      }
      format.json{
        render :json => @location_scope.all 
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Location.attribute_names
          @location_scope.all.each{ |o|
            csv << Location.attribute_names.map{ |a| o[a] }
          }
        end 
        render :text => csvstr
      }
      format.xml{ 
        render :xml => @location_scope.all 
      }             
      format.pdf{
        pdfcontent = PdfReport.new.to_pdf(Location,@location_scope)
        send_data pdfcontent
      }
    end
  end

  def show
    respond_to do |format|
      format.html{
        if request.headers['X-PJAX']
          render :layout => false
        else
          render
        end
      }
      format.json { render :json => @location }
    end
  end

  def new
    @location = Location.new

    respond_to do |format|
      format.html{
        if request.headers['X-PJAX']
          render :layout => false
        else
          render
        end
      }
      format.json { render :json => @location }
    end
  end

  def edit
    
  end

  def create
   # @location = Location.create(location_params)
    
    @location = Location.new(location_params)
        
    respond_to do |format|
      if @location.save
        format.html {
          if params[:mass_inserting] then
            redirect_to locations_path(:mass_inserting => true)
          else
            redirect_to location_path(@location), :notice => t(:create_success, :model => "location")
          end
        }
        format.json { render :json => @location, :status => :created, :location => @location }
      else
        format.html {
          if params[:mass_inserting] then
            redirect_to locations_path(:mass_inserting => true), :error => t(:error, "Error")
          else
            render :action => "new"
          end
        }
        format.json { render :json => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      
     
      if @location.update(location_params)
        format.html { redirect_to location_path(@location), :notice => t(:update_success, :model => "location") }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @locations = []    
    
    Location.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:location)

        @locations = Location.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @locations = Location.find(params[:ids].to_a)
      end

      @locations.each{ |location|
        if not Location.columns_hash[attr_or_method].nil? and
               Location.columns_hash[attr_or_method].type == :boolean then
         location.update_attribute(attr_or_method, boolean(value))
         location.save
        else
          case attr_or_method
          # Set here your own batch processing
          # location.save
          when "destroy" then
            location.destroy
          end
        end
      }
    end
    
    redirect_to :back
  end

  def treeview

  end

  def treeview_update
    modelclass = Location
    foreignkey = :location_id

    render :nothing => true, :status => (update_treeview(modelclass, foreignkey) ? 200 : 500)
  end
  
  private 
  
  def load_location
    @location = Location.find(params[:id])
  end
  
  def location_params
    params.require(:location).permit(:name, :lat, :lon, :description, :locationType, :insideR, :nearR ,:objectsPresent, :lastupdate)
  end
  
  
end

