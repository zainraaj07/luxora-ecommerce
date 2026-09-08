function toggleMenu(){document.querySelector('.main-nav')?.classList.toggle('open')}
document.querySelectorAll('[data-confirm]').forEach(el=>el.addEventListener('click',e=>{if(!confirm(el.dataset.confirm))e.preventDefault()}));
setTimeout(()=>document.querySelector('.toast')?.remove(),3600);

(function(){
  const btn=document.getElementById('mobileFilterBtn');
  const sidebar=document.querySelector('.shop-sidebar');
  if(btn&&sidebar){
    btn.addEventListener('click',()=>sidebar.classList.toggle('mobile-open'));
    sidebar.addEventListener('click',e=>{if(e.target===sidebar&&window.innerWidth<=800)sidebar.classList.remove('mobile-open')});
  }
})();
