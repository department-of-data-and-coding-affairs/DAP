from django import template
from django.template.defaultfilters import stringfilter
from django.utils.safestring import mark_safe
import markdown as md


register = template.Library()


@register.filter(is_safe=True)
@stringfilter
def markdown(value):
    result = md.markdown(
        value,
        extensions=[
            "extra",
            "codehilite",
            "toc",
        ],
    )
    return mark_safe(result)
