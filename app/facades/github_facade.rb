class GithubFacade
  attr_reader :token
  def initialize(token)
    @token = token
  end

  def repos
    github_data = GithubApiService.new(token).repos
    github_data.map do |repo|
      Repo.new(repo)
    end
  end

  def following
    user_data = GithubApiService.new(token).following
    user_data.map do |user|
      FollowingUser.new(user)
    end
  end

  def followers
    user_data = GithubApiService.new(token).followers
    user_data.map do |user|
      FollowerUser.new(user)
    end
  end
end
