class CampaignsController < ApplicationController
    before_action :set_campaign, only: [:edit, :update, :destroy]
  
  
    def index
        @campaigns = Campaign.where('fecha >= ? AND activa = ?', Date.current, true).order(fecha: :asc)
      end
  
    def new
        @campaign = Campaign.new(activa: true)
        @tarjeta = Tarjeta.new

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
    
    
    def pay
      @campaign = Campaign.find(params[:id])
      Rails.logger.debug(params.inspect)
    
      if request.post?
        if params.dig(:tarjeta).present?
          @tarjeta_params = tarjeta_params
          @tarjeta = Tarjeta.find_by(numero: @tarjeta_params[:numero])
    
          if @tarjeta.present? && @tarjeta.valid? &&
             @tarjeta.codigo == @tarjeta_params[:codigo].to_i &&
             @tarjeta.vencimiento.to_date == @tarjeta_params[:vencimiento].to_date &&
             @tarjeta.nombre == @tarjeta_params[:nombre] &&
             @tarjeta.dni == @tarjeta_params[:dni].to_i
    
            if @tarjeta_params[:monto_temporal].to_i > @tarjeta.saldo
              flash.now[:error] = 'El monto de la donación excede el saldo de la tarjeta.'
              render action: :pay, locals: { tarjeta: @tarjeta_params }
            elsif @tarjeta_params[:monto_temporal].to_i > @campaign.monto
              flash.now[:error] = 'El monto de la donación excede el monto total de la campaña.'
              render action: :pay, locals: { tarjeta: @tarjeta_params }
            else
              # Lógica para realizar la donación, actualizar el saldo, etc.
              # ...
              @tarjeta.saldo -= @tarjeta_params[:monto_temporal].to_i
              @tarjeta.save
    
              # Configura un mensaje de éxito
              flash[:success] = '¡Pago exitoso! Gracias por tu donación.'
              redirect_to campaigns_path, notice: '¡Pago exitoso! Gracias por tu donación.'
            end
          else
            # Si hay errores en la tarjeta o el monto, configura un mensaje de error
            flash.now[:error] = 'No se pudo procesar la donación. Verifica los datos de la tarjeta.'
            render action: :pay, locals: { tarjeta: @tarjeta_params }
          end
        else
          # Manejar el caso en el que no se proporcionan parámetros de tarjeta
          render action: :pay
        end
      end
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

    def tarjeta_params
      params.require(:tarjeta).permit(:numero, :nombre, :codigo, :monto_temporal, :vencimiento, :dni)
    end
    
    
    
  end
  