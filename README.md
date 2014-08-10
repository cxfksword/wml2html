# wml2html

Transform wml to html with Nginx [HttpXsltModule](http://wiki.nginx.org/HttpXsltModule).

## Usage

1. Install Ningx with modules:
 - HttpXsltModule  (--with-http_xslt_module)
 - sub_filter (--with-http_sub_module)  : use to replace some invalid xml entity
2. Upload ```wml.js``` to you app
3. Change ```wml2html.xslt```'s js path:
```<script  src="/js/wml.js" type="text/javascript"></script>```
4. Add config to your Nginx configuration file:
```
    location / {
        # some config
        
        sub_filter_types text/vnd.wap.wml;
        sub_filter "&nbsp;" "&#160;";
        xslt_types text/vnd.wap.wml;
        xslt_stylesheet /path/to/wml2html.xsl;
    }
```
