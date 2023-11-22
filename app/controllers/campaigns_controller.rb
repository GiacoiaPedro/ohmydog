class CampaignsController < ApplicationController
    before_action :set_campaign, only: [:edit, :update, :destroy]
  
  
    def index
        @campaigns = Campaign.where('fecha >= ? AND activa = ?', Date.current, true).order(fecha: :asc)
      end
  
    def new
        @campaign = Campaign.new(activa: true)
      end
    
      def create
        @campaign = Campaign.new(campaign_params)
    
        if @campaign.save
          redirect_to campaigns_path, notice: 'Campaña creada exitosamente.'
        else
          render :new
        end
      end
  
    def edit
    end
  
    def update
      if @campaign.update(campaign_params)
        redirect_to campaigns_path, notice: 'Campaña actualizada exitosamente.'
      else
        render :edit
      end
    end

    def destroy
        @campaign.update(activa: false)
        redirect_to campaigns_path, notice: 'Campaña desactivada exitosamente.'
      end
      
      def search
        query = params[:query]
        @campaigns = Campaign.where('nombre LIKE ? AND activa = ? AND fecha >= ?', "%#{query}%", true, Date.current)
    
        render :index
      end
    private
  
    def campaign_params
      params.require(:campaign).permit(:nombre, :descripcion, :monto, :imagen, :fecha)
    end
  
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end
  end
  