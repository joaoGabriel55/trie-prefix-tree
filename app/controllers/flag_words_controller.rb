class FlagWordsController < ApplicationController
    def flag
        service = FlagWordsService.new(text: params[:text])

        render json: { flag_words: service.flag_words }, status: :ok
    end
end
