module ApplicationHelper
  def default_meta_tags
    {
      site: 'はつめい屋 英語えもん',
      title: 'プログラミングで頻出する英単語をネイティブ「っぽく」読めるようになるサービス',
      reverse: true,
      charset: 'utf-8',
      description: 'わざわざ学ばなくてもよいことを、たまにはわざわざ学んでみよう！',
      keywords: '英語,発音,プログラミング,クイズ',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp2.png'),
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image',
        image: image_url('ogp2.png')
      }
    }
  end
end