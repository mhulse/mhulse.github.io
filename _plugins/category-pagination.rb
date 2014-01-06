# https://github.com/ilyakhokhryakov/jekyll-tagging-pagination/
module Jekyll

  class CategoryGenerator < Generator
    safe true
    
    def generate(site)
      if site.layouts.key? 'category'
        site.categories.keys.each do |category|
          paginate(site, category)
        end
      end
    end

    def paginate(site, category)
      category_posts = site.posts.find_all {|post| post.categories.include?(category)}.sort_by {|post| -post.date.to_f}
      num_pages = CategoryPager.calculate_pages(category_posts, site.config['paginate'].to_i)

      (1..num_pages).each do |page|
        pager = CategoryPager.new(site, page, category_posts, category, num_pages)
        dir = File.join('category', category, page > 1 ? "page#{page}" : '')
        page = CategoryPage.new(site, site.source, dir, category)
        page.pager = pager
        site.pages << page
      end
    end
  end

  class CategoryPage < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category.html')
      self.data['category'] = category
      #self.data['title'] = "Posts Categorized &ldquo;"+category+"&rdquo;"
    end
  end

  class CategoryPager < Pager 
    attr_reader :category

    def initialize(site, page, all_posts, category, num_pages = nil)
      @category = category
      super site, page, all_posts, num_pages
    end

    alias_method :original_to_liquid, :to_liquid

    def to_liquid
      liquid = original_to_liquid
      liquid['category'] = @category
      liquid
    end
  end

end
