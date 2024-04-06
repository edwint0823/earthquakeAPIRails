module Api
  class CommentsController < ApplicationController

    def create
      unless validate_request_params
        render json: { error: 'Es contenido del comentario es requerido' }, status: :unprocessable_entity
        return
      end
      feature = Feature.find_by(id: params[:feature_id])
      if feature.nil?
        render json: {error: "No se encontró el feature con id #{params[:feature_id]}" }, status: :unprocessable_entity
      else
        comment = feature.comments.build(comment_params)
        if comment.save
          render json: comment, status: :created
        else
          render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end

    private

    def comment_params
      params.permit(:body)
    end

    def validate_request_params
      return false unless params[:body].present? && params[:body] != ''

      true
    end

  end
end
