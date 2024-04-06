module Api
  class FeaturesController < ApplicationController
    before_action :set_per_page, only: :index
    before_action :validate_per_page, only: :index
    before_action :set_mag_type, only: :index

    def index
      features = Feature.all
      features = Feature.filter_by_mag_type(@mag_type) if @mag_type.present?
      paginated_features = features.paginate(page: params[:page], per_page: @per_page)
      serialized_features = paginated_features.map { |feature| serialize_feature(feature) }
      render json: {
        data: serialized_features,
        pagination: {
          curren_page: params[:page].to_i,
          total: features.count,
          per_page: @per_page
        }
      }
    end

    private

    def set_per_page
      @per_page = params[:per_page].present? ? params[:per_page].to_i : 10
    end

    def validate_per_page
      if @per_page > 1000
        render json: {error: 'Error la cantidad maxima de registros a mostrar es de 1000'}
      end
    end

    def set_mag_type
      @mag_type = params[:mag_type].present? ? params[:mag_type] : nil
    end

    def serialize_feature(feature)
      {
        id: feature.id,
        type: 'feature',
        attributes: {
          external_id: feature.external_id,
          magnitude: feature.mag,
          place: feature.place,
          time: feature.time.to_s,
          tsunami: feature.tsunami,
          mag_type: feature.mag_type,
          title: feature.title,
          coordinates: {
            longitude: feature.longitude,
            latitude: feature.latitude
          }
        },
        links: {
          external_url: feature.url
        }
      }
    end
  end
end
