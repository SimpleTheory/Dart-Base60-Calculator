'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "0ae9f0443f1429c946295cb18507bbff",
"assets/AssetManifest.json": "cfc98f25447792b9c38dacb06c3edcec",
"assets/assets/explanation_pdfs/HowtheAppWork/how%2520the%2520app%2520works_page-0001.jpg": "bd1b24b1af49ca65f9064e3f76e3711e",
"assets/assets/explanation_pdfs/HowtheAppWork/how%2520the%2520app%2520works_page-0001_inversion.jpg": "a9ffbc738ce0f7e013430cb47ff61de6",
"assets/assets/explanation_pdfs/HowtheAppWork/how%2520the%2520app%2520works_page-0002.jpg": "0fb092b406dfce8456a9dea610cde35b",
"assets/assets/explanation_pdfs/HowtheAppWork/how%2520the%2520app%2520works_page-0002_inversion.jpg": "67391bc6b5248c979f2a4f66b24b0b0a",
"assets/assets/explanation_pdfs/HowtheAppWork/how%2520the%2520app%2520works_page-0003.jpg": "0c6f23047bf9ab928b92e36098e10af9",
"assets/assets/explanation_pdfs/HowtheAppWork/how%2520the%2520app%2520works_page-0003_inversion.jpg": "a83775b2ab8aba71ecafb01f7e57a18c",
"assets/assets/explanation_pdfs/HowtheAppWork/how%2520the%2520app%2520works_page-0004.jpg": "d1bc8f78b9a65f363530c854680314d2",
"assets/assets/explanation_pdfs/HowtheAppWork/how%2520the%2520app%2520works_page-0004_inversion.jpg": "fdcd682e703cee06072404d05069a1f5",
"assets/assets/explanation_pdfs/HowtheNumbersWork/0001.jpg": "e65e892ff0ab66d3a4f82ee0e8cbcb25",
"assets/assets/explanation_pdfs/HowtheNumbersWork/0001_inversion.jpg": "02d37eef2edc45b818532249a4d937a1",
"assets/assets/explanation_pdfs/HowtheNumbersWork/0002.jpg": "6cbcf1205e66df01aeec6c883c525dd1",
"assets/assets/explanation_pdfs/HowtheNumbersWork/0002_inversion.jpg": "33fd307d12f4b842e41c7c5dbd853622",
"assets/assets/explanation_pdfs/HowtheNumbersWork/0003.jpg": "94f5d41cf6393560aa04f3fd57f353b7",
"assets/assets/explanation_pdfs/HowtheNumbersWork/0003_inversion.jpg": "359114a6700642debdbde747fd90dca3",
"assets/assets/explanation_pdfs/HowtheNumbersWork/0004.jpg": "082172dc21b34dda9cc2d92922ca492c",
"assets/assets/explanation_pdfs/HowtheNumbersWork/0004_inversion.jpg": "dd662ceccdfc0f98bbe71413fb915171",
"assets/assets/explanation_pdfs/HowtheNumbersWork/0005.jpg": "e9d1690a31b92741483eecdfcad230bb",
"assets/assets/explanation_pdfs/HowtheNumbersWork/0005_inversion.jpg": "e5b027361a95b6a002f19668a9cc2775",
"assets/assets/explanation_pdfs/WhatisBase60/0001.jpg": "c685d4e8c9b7a3f7daaa13c6350e1ba1",
"assets/assets/explanation_pdfs/WhatisBase60/0001_inversion.jpg": "86df519464ec48488856d7d77fb94178",
"assets/assets/explanation_pdfs/WhatisBase60/0002.jpg": "0390c038382286094299d0c5966e22fd",
"assets/assets/explanation_pdfs/WhatisBase60/0002_inversion.jpg": "98862521913ee3623e85791f313ce6e7",
"assets/assets/explanation_pdfs/WhatisBase60/0003.jpg": "6cc8a7b98288b73d1b760bbe1bb9ddd4",
"assets/assets/explanation_pdfs/WhatisBase60/0003_inversion.jpg": "d6bf0a9bca74a14031579f393c275f53",
"assets/assets/explanation_pdfs/WhatisBase60/0004.jpg": "d741e9742728d4db6ca4798bd0dda12a",
"assets/assets/explanation_pdfs/WhatisBase60/0004_inversion.jpg": "9b7d3f4579deb0cf512931d4027ea641",
"assets/assets/explanation_pdfs/WhatisBase60/0005.jpg": "bb117038f0abadf25b6665bba324e5ba",
"assets/assets/explanation_pdfs/WhatisBase60/0005_inversion.jpg": "b780417642b04182283539ba3b482d12",
"assets/assets/fonts/Base60Alpha20-Regular.ttf": "79cea3da64c635513d0b04e7d649b4e1",
"assets/assets/imgs/calc_labeled.png": "f5e395f3598c4aec480d1eb48b4634ab",
"assets/assets/imgs/keyboard_use_example.gif": "653bc3e5e5d1a85f663fda9b09338cf5",
"assets/FontManifest.json": "9da2885cb425350d40496acf44ac6b3b",
"assets/fonts/MaterialIcons-Regular.otf": "32fce58e2acb9c420eab0fe7b828b761",
"assets/NOTICES": "a9194cb9d420af11d4ae7a57b97fec65",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e31bc2d27742e6eb60db36cacabba2cd",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "bf0286603355e09ed21671926e9c1125",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "f0cd99d760053a4a17197eb0e481adbc",
"icons/Icon-512.png": "c900fd6d36360fc33a0c02a7e9d66709",
"icons/Icon-maskable-192.png": "f0cd99d760053a4a17197eb0e481adbc",
"icons/Icon-maskable-512.png": "c900fd6d36360fc33a0c02a7e9d66709",
"index.html": "5b04168ad828d9e9c4f9ae7b803d70a7",
"/": "5b04168ad828d9e9c4f9ae7b803d70a7",
"main.dart.js": "906e35b8cb27bb7a1f566efdcefb2bfd",
"manifest.json": "1af0ecb43fa39f3555858bf65c5a4873",
"version.json": "c70e9b274384061771afab44e053b7bc"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
