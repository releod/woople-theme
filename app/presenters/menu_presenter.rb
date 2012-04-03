require 'delegate'
require 'action_view'

class MenuPresenter < SimpleDelegator
  def initialize(menu)
    super(ThemePresentation.wrap_collection(menu, MenuSectionPresenter))
  end
end

class MenuSectionPresenter < SimpleDelegator
  def name
    yield(section.name) if section.respond_to? :name
  end

  def links
    @links ||= ThemePresentation.wrap_collection(section.links, MenuLinkPresenter)
  end

  private

  def section
    __getobj__
  end

end

class MenuLinkPresenter < SimpleDelegator
  include ActionView::Helpers::TagHelper

  def featured_tag(name)
    if featured?
      content_tag(:em, name.html_safe)
    else
      name
    end
  end

  def badge
    return "" if no_badge?

    content_tag(:span, link.badge, class: 'badge')
  end

  def certification_badge
   return "" if no_certification_badge?

    content_tag(:span, content_tag(:i, '', class: "cert-status-#{link.certification_badge}") + " #{link.certification_badge.titleize}", class: 'badge label-icon')
  end

  def css_class
    "active" if selected?
  end

  private

  def link
    __getobj__
  end

  def featured?
    link.respond_to?(:featured) && link.featured
  end

  def no_badge?
    !link.respond_to?(:badge)
  end

  def no_certification_badge?
    !link.respond_to?(:certification_badge)
  end

  def selected?
    link.respond_to?(:selected) && link.selected
  end
end
