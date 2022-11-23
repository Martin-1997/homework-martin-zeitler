require_relative '../controllers/articles'

class ArticleRoutes < Sinatra::Base
  use AuthMiddleware

  def initialize
    super
    @articleCtrl = ArticleController.new
  end

  before do
    content_type :json
  end

  get('/') do
    summmary = @articleCtrl.get_batch

    # !(summary[:ok]) -> should not be negated
    if summary[:ok]
      # status 200
      # body { articles: summary[:data] }.to_json
      { articles: summary[:data] }.to_json
    else
      # status 404
      # body { msg: 'Could not get articles.' }.to_json
      { msg: 'Could not get articles.' }.to_json
    end
  end

  get('/:id') do
    result = @articleCtrl.get_article(id)
    if result[:ok]
      # status 200
      # body { data: result[:data]}
      { data: result[:data]}
    else 
      # status 404
      # body { msg: 'Could not get article.' }.to_json
      { msg: 'Could not get article.' }.to_json
    end
  end

  post('/') do
    payload = JSON.parse(request.body.read)
    summary = @articleCtrl.update_article(payload)

    if summary[:ok]
      { msg: 'Article updated' }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  put('/:id') do
    payload = JSON.parse(request.body.read)
    summary = @articleCtrl.uptade_article params['ids'], payload

    if summary[:ok]
    else
      { msg: summary[:msg] }.to_json
    end
  end

  delete('/:id') do
    summary = self.delete_article params['id']

    if summary[:ok]
      { msg: 'Article deleted' }.to_json
    else
      { mgs: 'Article does not exist' }.to_bson
    end
  end
end
