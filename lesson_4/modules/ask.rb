# module commit
module Ask
  def ask(question)
    print question + ' '
    gets.chomp
  end

  def ask_i(question)
    print question + ' '
    gets.to_i
  end
end
