class CoverLetterGenerator
  def initialize(options)
    @company = options[:company]
    @address = options[:address]
    @reasons = options[:reasons]
    @position = options[:position]
    @board = options[:board]
  end

  def header_block
    [
      "#{Time.now.strftime("%B #{Time.now.day.ordinalize}, %Y")}",
      "#{@company} ",
      "#{@address}"
    ]
  end

  def intro_paragraph
    "Hello, my name is Morgan Martin and I'd like to apply for the #{@position} position you posted on #{@board}. #{@company} caught my eye because #{@reasons}"
  end
end
