# encoding : utf-8
require 'yaml'  
class SettingsController < ApplicationController

  before_filter :load_setting, :only => [:show, :edit, :update, :destroy]

  # Uncomment for check abilities with CanCan
  #authorize_resource

  def index
    session[:fields] ||= {}
    session[:fields][:setting] ||= (Setting.columns.map(&:name) - ["id"])[0..4]
    do_select_fields(:setting)
    do_sort_and_paginate(:setting)
    
    @q = Setting.search(
      params[:q]
    )

    @setting_scope = @q.result(
      :distinct => true
    ).sorting(
      params[:sorting]
    )
    
    @setting_scope_for_scope = @setting_scope.dup
    
    unless params[:scope].blank?
      @setting_scope = @setting_scope.send(params[:scope])
    end
    
    @settings = @setting_scope.paginate(
      :page => params[:page],
      :per_page => 20
    ).to_a

    respond_to do |format|
      format.html{
        render
      }
      format.json{
        render :json => @setting_scope.to_a
      }
      format.csv{
        require 'csv'
        csvstr = CSV.generate do |csv|
          csv << Setting.attribute_names
          @setting_scope.to_a.each{ |o|
            csv << Setting.attribute_names.map{ |a| o[a] }
          }
        end 
        render :text => csvstr
      }
      format.xml{ 
        render :xml => @setting_scope.to_a
      }             
      format.pdf{
        pdfcontent = PdfReport.new.to_pdf(Setting,@setting_scope)
        send_data pdfcontent
      }
    end
  end

  def show
    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @setting }
    end
  end

  def new
    @setting = Setting.new

    respond_to do |format|
      format.html{
        render
      }
      format.json { render :json => @setting }
    end
  end

  def edit
    params[:locale] ||= app_set('locale')
  end

  def create
    @setting = Setting.create(params_for_model)
    params[:locale] ||= app_set('locale')
    respond_to do |format|
      if @setting.save
        format.html {
          if params[:mass_inserting] then
            redirect_to settings_path(:mass_inserting => true)
          else
            redirect_to setting_path(@setting), :flash => { :notice => t(:create_success, :model => "setting") }
          end
        }
        format.json { render :json => @setting, :status => :created, :location => @setting }
      else
        format.html {
          if params[:mass_inserting] then
            redirect_to settings_path(:mass_inserting => true), :flash => { :error => t(:error, "Error") }
          else
            render :action => "new"
          end
        }
        format.json { render :json => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    params[:locale] ||= app_set('locale')
    respond_to do |format|
      if @setting.update_attributes(params_for_model)
        format.html { redirect_to setting_path(@setting), :flash => { :notice => t(:update_success, :model => "setting") }}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @setting.destroy

    respond_to do |format|
      format.html { redirect_to settings_url }
      format.json { head :ok }
    end
  end

  def batch
    attr_or_method, value = params[:actionprocess].split(".")

    @settings = []    
    
    Setting.transaction do
      if params[:checkallelt] == "all" then
        # Selected with filter and search
        do_sort_and_paginate(:setting)

        @settings = Setting.search(
          params[:q]
        ).result(
          :distinct => true
        )
      else
        # Selected elements
        @settings = Setting.find(params[:ids].to_a)
      end

      @settings.each{ |setting|
        if not Setting.columns_hash[attr_or_method].nil? and
               Setting.columns_hash[attr_or_method].type == :boolean then
         setting.update_attribute(attr_or_method, boolean(value))
         setting.save
        else
          case attr_or_method
          # Set here your own batch processing
          # setting.save
          when "destroy" then
            setting.destroy
          end
        end
      }
    end
    
    redirect_to :back
  end

  def treeview

  end

  def treeview_update
    modelclass = Setting
    foreignkey = :setting_id

    render :nothing => true, :status => (update_treeview(modelclass, foreignkey) ? 200 : 500)
  end
  
  
 def init
    file = (APP_CONFIG[Rails.env]['root']+'config\config.yml')||'c:\users\ozp\apps\flatui\config\config.yml'
    newsettings = YAML.load(File.read(file))  
    id=0
    newsettings[Rails.env].each do |par|
      id+=1
       @newsetting = Setting.find_by_key(par[0])
        if @newsetting !=nil then
          @newsetting.value = par[1]
          @newsetting.save
        else
          @newsetting = Setting.new
          @newsetting.key = par[0]
          @newsetting.value = par[1]
          @newsetting.mytype =par[1].class.to_s
          @newsetting.save
        end 
      end  
     @settings = Setting.all
     return ("Update / Created:"+id.to_s) 
  end   
  
  private 
  
  def load_setting
    @setting = Setting.find(params[:id])
  end

  def params_for_model
    params.require(:setting).permit(Setting.permitted_attributes)
  end
end

