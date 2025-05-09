---
title: Map
weight: 18
menu: main
---

{{< rawhtml >}}
<!-- Tab navigation -->
<ul class="nav nav-tabs mb-4" id="mapTabs" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="erisia-tab" data-bs-toggle="tab" data-bs-target="#erisia" type="button" role="tab" aria-controls="erisia" aria-selected="true">Erisia</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="incognito-tab" data-bs-toggle="tab" data-bs-target="#incognito" type="button" role="tab" aria-controls="incognito" aria-selected="false">Test server</button>
  </li>
</ul>

<!-- Tab content -->
<div class="tab-content" id="mapTabsContent">
  <div class="tab-pane fade show active" id="erisia" role="tabpanel" aria-labelledby="erisia-tab">
    <iframe src="https://map.brage.info/" width="100%" height="600" style="border:0"></iframe>
  </div>
  <div class="tab-pane fade" id="incognito" role="tabpanel" aria-labelledby="incognito-tab">
    <iframe src="https://incognito.brage.info/" width="100%" height="600" style="border:0"></iframe>
  </div>
</div>
{{< /rawhtml >}}