class CoverLettersController < ApplicationController

  def show
    options = params
    c = CoverLetterGenerator.new(options)
    @position = params[:position]
    @header_block = c.header_block
    @intro_paragraph = c.intro_paragraph
  end


  private

  def cover_letter_params
    params.require(:cover_letter).permit(:company, :address, :reasons, :board)
  end
end
