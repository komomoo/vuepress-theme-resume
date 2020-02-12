<template>
  <div class="theme-container"
    :class="pageClasses"
    @touchstart="onTouchStart"
    @touchend="onTouchEnd">
    <div class="sidebar-mask"
      @click="toggleSidebar(false)"></div>
    <Sidebar :items="sidebarItems"
      @toggle-sidebar="toggleSidebar">
      <slot name="sidebar-top"
        slot="top" />
      <slot name="sidebar-bottom"
        slot="bottom" />
    </Sidebar>
    <div class="custom-layout"
      v-if="$page.frontmatter.layout">
      <component :is="$page.frontmatter.layout" />
    </div>
    <Page v-else
      :sidebar-items="sidebarItems">
      <slot name="page-top"
        slot="top" />
      <slot name="page-bottom"
        slot="bottom" />
    </Page>
  </div>
</template>

<script>
import Vue from "vue";
import nprogress from "nprogress";
import Page from "../components/Page.vue";
import Sidebar from "../components/Sidebar.vue";
import { resolveSidebarItems } from "../utils";

export default {
  components: { Page, Sidebar },
  data() {
    return {
      isSidebarOpen: false
    };
  },

  computed: {
    shouldShowSidebar() {
      const { frontmatter } = this.$page;
      return (
        !frontmatter.layout &&
        !frontmatter.home &&
        frontmatter.sidebar !== false &&
        this.sidebarItems.length
      );
    },
    sidebarItems() {
      return resolveSidebarItems(
        this.$page,
        this.$route,
        this.$site,
        this.$localePath
      );
    },
    pageClasses() {
      const userPageClass = this.$page.frontmatter.pageClass;
      return [
        {
          "no-navbar": !this.shouldShowNavbar,
          "sidebar-open": this.isSidebarOpen,
          "no-sidebar": !this.shouldShowSidebar
        },
        userPageClass
      ];
    }
  },

  mounted() {
    window.addEventListener("scroll", this.onScroll);

    // configure progress bar
    nprogress.configure({ showSpinner: false });

    this.$router.beforeEach((to, from, next) => {
      if (to.path !== from.path && !Vue.component(to.name)) {
        nprogress.start();
      }
      next();
    });

    this.$router.afterEach(() => {
      nprogress.done();
      this.isSidebarOpen = false;
    });
  },

  methods: {
    toggleSidebar(to) {
      this.isSidebarOpen = typeof to === "boolean" ? to : !this.isSidebarOpen;
    },
    // side swipe
    onTouchStart(e) {
      this.touchStart = {
        x: e.changedTouches[0].clientX,
        y: e.changedTouches[0].clientY
      };
    },
    onTouchEnd(e) {
      const dx = e.changedTouches[0].clientX - this.touchStart.x;
      const dy = e.changedTouches[0].clientY - this.touchStart.y;
      if (Math.abs(dx) > Math.abs(dy) && Math.abs(dx) > 40) {
        if (dx > 0 && this.touchStart.x <= 80) {
          this.toggleSidebar(true);
        } else {
          this.toggleSidebar(false);
        }
      }
    }
  }
};
</script>

<style src="prismjs/themes/prism-tomorrow.css"></style>