require_relative '../controllers/articles'

class ArticleRoutes <  Sinatra::Base # Inheritance
  use AuthMiddleware

  def initialize
    super
    @articleCtrl = ArticleController.new
  end

  before do
    content_type :json
  end

  get('/') do
    summary = @articleCtrl.get_batch

    # !(summary[:ok]) -> should not be negated
    if summary[:ok]
      { articles: summary[:data] }.to_json
    else
      { msg: 'Could not get articles.' }.to_json
    end
  end

  get('/:id') do

    result = @articleCtrl.get_article(params['id'])


    if result[:ok]
      { article: result[:data]}.to_json
    else 
      { msg: 'Could not get article.' }.to_json
    end
  end

  post('/') do
    payload = JSON.parse(request.body.read)
    summary = @articleCtrl.create_article(payload)

    if summary[:ok]
      { msg: 'Article created' }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  put('/:id') do
    payload = JSON.parse(request.body.read)
    summary = @articleCtrl.update_article(params['id'], payload)

    if summary[:ok]
      { msg: 'Article updated'}.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  delete('/:id') do
    summary = @articleCtrl.delete_article(params['id'])

    if summary[:ok]
      { msg: 'Article deleted' }.to_json
    else
      { msg: 'Article does not exist' }.to_json
    end
  end
end
