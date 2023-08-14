module ApplicationHelper
  def default_meta_tags
    {
      site: 'はつめい屋 英語えもん',
      title: 'わざわざ学ばなくてもよいことだけを楽しく学べるサービスです。',
      reverse: true,
      charset: 'utf-8',
      description: '英語えもんを使って、プログラミングで頻出する英単語をネイティブっぽく読んでみよう！',
      keywords: '英語,発音,プログラミング,娯楽',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image',
        image: image_url('ogp.png')
      }
    }
  end
end