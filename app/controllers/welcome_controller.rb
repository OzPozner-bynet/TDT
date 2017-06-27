class WelcomeController < ApplicationController
  def index
    @title = I18n.t('index')
    render 'bynetsoft/index'
  end
  
  def demo
    @title = I18n.t('demo')
  end

  def locate
      @title = I18n.t('GPS locate')
      render "geolocate", :layout => false 
  end
   
   
  def tv
    @title = I18n.t('tv')
    render :layout => false
  end 
  
  def cctv
      @title = I18n.t('tv')
      render "index2", :layout => false
  end 

  def ol
    render :partial => "openLayers", :remote => true, :layout => "ol"
  end
  
  def olh
      render :partial => "openLayers_home", :remote => true, :layout => "ol"
    end
  def tvnew
    render :layout => false
  end 
  
  def home
    # render :layout => false
    @title = I18n.t('home')
   end
    
  def maps
    @title = I18n.t('maps')
     render :partial => "oz", :remote => true , :layout=> false
   end 
  def tree
    @title = I18n.t('tree')
    render :partial => "jstree"
  end
  
  def main
    render :partial => "main"
  end
    
  
  def driver_view
    @title = I18n.t('Driver_view')
  end
  
  def mylayer
    
  end
  
   def mystatus
     @title = I18n.t('status')
     render "status", :remote => true , :layout=> false
   end
  
end
