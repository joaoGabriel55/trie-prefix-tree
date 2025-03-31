class FlagWordsController < ApplicationController
    def flag
        service = FlagWordsService.new(text: params[:text], forbidden_words:)

        render json: { flag_words: service.flag_words }, status: :ok
    end

    private

    def forbidden_words
        %w[foo bar baz]
    end
end
