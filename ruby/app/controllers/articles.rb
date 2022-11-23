class ArticleController
  def create_article(article)
    # article_not_exists = ! (Article.where(:title => article['title']).empty?)
    # "!" negates the result 
    article_not_exists = (Article.where(:title => article['title']).empty?)
    

    return { ok: false, msg: 'Article with given title already exists' } unless article_not_exists

    new_article = Article.new(:title => article['title'], :content => article['content'], :created_at => Time.now)
    new_article.save
    # This needs to be true instead of false
    { ok: true, obj: article }
  rescue StandardError
    { ok: false }
  end

  def update_article(id, new_data)

    article = Article.where(id: id).first

    if article.nil?
      return { ok: false, msg: 'Article could not be found' }
    end

    article.title = new_data['title']
    article.content = new_data['content']
    # Use "save" instead of "save_changes"
    article.save
    # Return the object
    { ok: true, obj: article }
  rescue StandardError
    { ok: false }
  end

  def get_article(id)
    res = Article.where(:id => id)

    if res.empty?
      { ok: false, msg: 'Article not found' } # 1. error These lines need to be switched
    else
      { ok: true, data: res }
    end
  rescue StandardError
    { ok: false }
  end

  # Changed "_id" to "id" to match the variable name in the function definition
  def delete_article(id)
    # returns the number of rows deleted
    # https://api.rubyonrails.org/v3.1/classes/ActiveRecord/Relation.html#method-i-delete
    delete_count = Article.delete(:id => id)

    if delete_count == 0
      # Should be false
      { ok: false }
    else
      { ok: true, delete_count: delete_count }
    end
  end

  # This method needed to be implemented 
  def get_batch()
    articles = Article.all()
    if articles.empty?
      { ok: false, msg: 'No articles available' } # 1. error These lines need to be switched
    else
      { ok: true, data: articles }
    end
  end
end
