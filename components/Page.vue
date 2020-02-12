<template>
  <div class="page">
    <Content class="content"
      :custom="false" />
  </div>
</template>

<script>
export default {
  props: ["sidebarItems"]
};
</script>

<style lang="stylus">
@import '../styles/config.styl';

.page {
  .content {
    font-size: $fontSize;
    font-family: menlo, pingfang;
    font-weight: $fontWeight;
    color: $textColor;

    * {
      margin: 0 !important;
    }

    > h1 {
      display: flex;
      align-items: center;

      > span {
        flex: 1;
        transform: translateY(-0.2em);
      }

      > ul {
        float: right;
        font-size: 12px;
        font-weight: normal;
        margin: 0;
        padding: 0;

        > li {
          display: flex;
          flex-wrap: nowrap;

          > span {
            flex-shrink: 0;
            width: 6em;
            text-align: right;

            &::after {
              content: ':';
              margin: 0 0.25em;
            }
          }
        }
      }
    }

    > h2, > h3 {
      line-height: 1;
      border: 0;
      padding: 0;
      display: flex;
      align-items: baseline;
      margin-bottom: 0.6em !important;

      .header-anchor {
        display: none;
      }
    }

    > h2 {
      font-size: 1.35em;
      display: flex;

      &:not(:first-of-type) {
        margin-top: 1em !important;
      }

      &::after {
        content: '';
        flex: 1;
        border-bottom: 2px dashed #D3D3D3;
        margin-left: 10px;
      }
    }

    > h3 {
      font-size: 1.1em;

      &:not(:first-of-type) {
        margin-top: 0.6em !important;
      }
    }

    > p, > ul, > ol {
      line-height: 1.5;
    }

    > p {
    }

    > ul {
      margin: 0;
      margin-top: 0.5em;
    }

    > hr {
      margin-top: 0.4em !important;
      border-top: 1px dashed $borderColor;
    }

    .role {
      flex: 1;
      font-size: 12px;
      text-align: left;
    }

    .right {
      float: right;
      flex: 1;
      font-size: 0.9em;
      text-align: right;
      font-weight: normal;
      font-style: italic;
    }
  }
}
</style>
