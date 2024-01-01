<template>
  <QuillEditor
    ref="quillEditorRef"
    theme="snow"
    :options="options"
    @blur="onEditorBlur"
    @focus="onEditorFocus"
    @ready="onEditorReady"
    @textChange="onEditorTextChange"
  />
</template>

<script setup>
import { QuillEditor, Delta, setContents } from "@vueup/vue-quill";
import "@vueup/vue-quill/dist/vue-quill.snow.css";
import "@vueup/vue-quill/dist/vue-quill.bubble.css";
import { ref, computed, onMounted } from "vue";

const options = ref({
  theme: "snow",
  placeholder: "请输入内容",
  modules: {
    toolbar: [
      [{ header: 1 }],
      [{ header: 2 }],
      ["bold"],
      ["background"],
      ["underline"],
      ["strike"],
      ["italic"],
      [{ list: "ordered" }],
      [{ list: "bullet" }],
      ["divider"],
      ["link"],
      ["undo"],
      ["redo"],
    ],
  },
  formats: [
    "header",
    "bold",
    "italic",
    "underline",
    "strike",
    "background",
    "link",
    "list",
  ],
});

const quillEditorRef = ref(QuillEditor);

onMounted(() => {
  console.log("++++++++++++++++++++++onMounted");
});

function onEditorBlur() {
  console.log("onEditorBlur--");
}
function onEditorFocus() {
  console.log("onEditorFocus--");
}
function onEditorReady() {
  console.log("onEditorReady--");
  let str =
    '[{"insert":"我是H1"},{"insert":"\\n","attributes":{"header":1}},{"insert":"北京"},{"insert":"\\n","attributes":{"list":"ordered"}},{"insert":"上海"},{"insert":"\\n","attributes":{"list":"ordered"}},{"insert":"深圳"},{"insert":"\\n","attributes":{"list":"ordered"}},{"insert":"公积金、社保、医保","attributes":{"color":"#e60000","bold":true}},{"insert":"\\n"},{"insert":"百度","attributes":{"link":"https://www.baidu.com"}},{"insert":"\\n"}]';
  let delta = JSON.parse(str);
  const quill = quillEditorRef.value.getQuill();
  if (quill) {
    quill.setContents(delta, "api");
  }
}
function onEditorTextChange() {
  console.log("onEditorTextChange--");
}
</script>
