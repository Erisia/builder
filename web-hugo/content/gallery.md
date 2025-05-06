---
title: Gallery
weight: 6
menu:
  main:
    weight: 6
---

<div id="gallery-container">
  <div class="alert alert-info text-center mb-4">
    Loading gallery content...
  </div>
</div>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
  const galleryContainer = document.getElementById('gallery-container');
  
  // Fetch gallery content from the reverse proxy
  fetch('https://madoka.brage.info/images/')
    .then(response => response.text())
    .then(html => {
      // Extract just the gallery content from the response
      const parser = new DOMParser();
      const doc = parser.parseFromString(html, 'text/html');
      
      // Get the gallery div and the CSS styles
      const gallery = doc.querySelector('.gallery');
      const styles = Array.from(doc.querySelectorAll('style')).map(style => style.textContent).join('\n');
      const scripts = Array.from(doc.querySelectorAll('script')).map(script => script.textContent).join('\n');
      
      if (gallery) {
        // Ensure all image URLs use the absolute URL with the correct host
        const images = gallery.querySelectorAll('img');
        images.forEach(img => {
          const imgSrc = img.getAttribute('src');
          // Make sure all image paths are absolute and keep the /images/ prefix
          if (imgSrc && imgSrc.startsWith('/')) {
            const fixedSrc = `https://madoka.brage.info${imgSrc}`;
            img.setAttribute('src', fixedSrc);
          }
        });
        
        // Add extracted styles to head
        const styleElement = document.createElement('style');
        styleElement.textContent = styles;
        document.head.appendChild(styleElement);
        
        // Replace the loading message with the gallery content
        galleryContainer.innerHTML = '';
        galleryContainer.appendChild(gallery);
        
        // Add the modal HTML
        const modalDiv = document.createElement('div');
        modalDiv.id = 'imageModal';
        modalDiv.className = 'modal';
        modalDiv.innerHTML = `
          <span class="close" onclick="closeModal()">&times;</span>
          <img class="modal-content" id="modalImage">
          <div id="caption" class="modal-caption"></div>
        `;
        document.body.appendChild(modalDiv);
        
        // Add the JavaScript
        const scriptElement = document.createElement('script');
        scriptElement.textContent = `
          function openModal(img) {
            const modal = document.getElementById("imageModal");
            const modalImg = document.getElementById("modalImage");
            const captionText = document.getElementById("caption");
            
            modal.style.display = "block";
            // Make sure we're using the full URL for the modal image
            modalImg.src = img.src;
            captionText.innerHTML = img.alt;
          }
          
          function closeModal() {
            document.getElementById("imageModal").style.display = "none";
          }
          
          // Close modal when clicking outside the image
          window.onclick = function(event) {
            const modal = document.getElementById("imageModal");
            if (event.target == modal) {
              closeModal();
            }
          }
          
          // Close modal with escape key
          document.addEventListener('keydown', function(event) {
            if (event.key === "Escape") {
              closeModal();
            }
          });
        `;
        document.body.appendChild(scriptElement);
      } else {
        galleryContainer.innerHTML = `
          <div class="alert alert-warning">
            <h2>Gallery Not Available</h2>
            <p>The image gallery is currently unavailable. Please check back later or contact an administrator.</p>
          </div>
        `;
      }
    })
    .catch(error => {
      console.error('Error loading gallery:', error);
      galleryContainer.innerHTML = `
        <div class="alert alert-danger">
          <h2>Error Loading Gallery</h2>
          <p>There was an error loading the gallery content. The gallery service may be offline.</p>
          <p>Error details: ${error.message}</p>
        </div>
      `;
    });
});
</script>

<!-- Additional CSS for the gallery page -->
<style>
.gallery {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-gap: 20px;
  margin-top: 20px;
}

.gallery-item {
  border: 1px solid var(--border-color, #383838);
  border-radius: 5px;
  overflow: hidden;
  background-color: var(--card-bg, #2a2a2a);
  transition: transform 0.2s;
}

.gallery-item:hover {
  transform: scale(1.02);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

.gallery-image {
  width: 100%;
  aspect-ratio: 1;
  object-fit: cover;
  cursor: pointer;
}

.gallery-info {
  padding: 10px;
  font-size: 0.9em;
  color: var(--text-secondary, #b0b0b0);
}

/* Modal styles */
.modal {
  display: none;
  position: fixed;
  z-index: 999;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.9);
}

.modal-content {
  margin: auto;
  display: block;
  max-width: 90%;
  max-height: 90%;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.close {
  position: absolute;
  top: 15px;
  right: 35px;
  color: #f1f1f1;
  font-size: 40px;
  font-weight: bold;
  cursor: pointer;
  z-index: 1000;
}

.modal-caption {
  margin: auto;
  display: block;
  width: 80%;
  text-align: center;
  color: #ccc;
  padding: 10px 0;
  position: absolute;
  bottom: 10px;
  left: 10%;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .gallery {
    grid-template-columns: repeat(2, 1fr);
    grid-gap: 10px;
  }
  
  .gallery-info {
    font-size: 0.8em;
  }
}

@media (max-width: 480px) {
  .gallery {
    grid-template-columns: 1fr;
  }
}
</style>