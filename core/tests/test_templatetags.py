from unittest import mock
from core.templatetags import render_markdown
from django.test import TestCase


MD_VAL = """# Hello

This is a paragraph.

* These
* are
* bullets

```
Here is some code
```
"""

HTML = """<h1 id="hello">Hello</h1>
<p>This is a paragraph.</p>
<ul>
<li>These</li>
<li>are</li>
<li>bullets</li>
</ul>
<div class="codehilite"><pre><span></span><code>Here is some code
</code></pre></div>"""


class MarkdownTagTestCase(TestCase):
    """
    Exercise the bespoke markdown tag.
    """

    def test_markdown_extensions(self):
        """
        Ensure the underlying markdown library is initiated with the expected
        extensions.
        """
        mock_md = mock.MagicMock()
        with mock.patch("core.templatetags.render_markdown.md", mock_md):
            render_markdown.markdown(MD_VAL)
            mock_md.markdown.assert_called_once_with(
                MD_VAL,
                extensions=[
                    "extra",
                    "codehilite",
                    "toc",
                ],
            )

    def test_markdown_result(self):
        """
        Ensure the resulting HTML is the expected output.
        """
        result = render_markdown.markdown(MD_VAL)
        self.assertEqual(result, HTML)
