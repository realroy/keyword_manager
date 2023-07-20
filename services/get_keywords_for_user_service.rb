class GetKeywordsForUserService
  def initialize(user:, q:)
    @user = user
    @q = q
  end

  def call
    if @q.present?
      @user.keywords.where('word ILIKE ?', "%#{@q}%")
    else
      @user.keywords
    end
  end
end
