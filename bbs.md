---
title: /bbs
layout: default
permalink: /bbs
---
<p style='text-align:center'>EXITNODE BBS<br />dial-up: 928-EXT-NODE<br />telnet/ssh: bbs.exitnode.io</p>
{% check_tcp_port bbs.exitnode.io:23 %}
{% if site.tcp_port_open %}
<script type='text/javascript' src='https://cdn.jsdelivr.net/pako/1.0.3/pako.min.js'></script>
<script type='text/javascript' src='assets/vtx/vtxdata.js'></script>
<script type='text/javascript' src='assets/vtx/vtxclient.min.js'></script>
<div style='text-align:center' class="bbs-lg-view"> 
  <div id='vtxclient' style='text-align:center;margin:0 auto;display:inline-block;padding:34px;'>
      <!-- VTX client will appears in here -->
  </div>
</div>
<div class="bbs-sm-view">
  <br />
  <p>This device is too small, you might want to bring a keyboard.</p>
</div>
{% else %}
<p style='text-align:center;font-family:retro;font-size:2em !important'>The BBS is currently offline. :(</p>
{% endif %}