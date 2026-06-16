<script setup lang="ts">
import { Moon, Sun, Logout } from '@vicons/tabler';
import { NIcon } from 'naive-ui';
import { useStyleStore } from '@/stores/style.store';

const styleStore = useStyleStore();

function goToDashboard() {
  window.location.href = '/user/dashboard';
}
</script>

<template>
  <c-tooltip :tooltip="styleStore.isDarkTheme ? 'Light mode' : 'Dark mode'" position="bottom">
    <c-button circle variant="text" aria-label="Toggle theme" @click="styleStore.toggleDark()">
      <NIcon size="20" :component="styleStore.isDarkTheme ? Sun : Moon" />
    </c-button>
  </c-tooltip>

  <c-tooltip tooltip="Exit to Dashboard" position="bottom">
    <c-button circle variant="text" aria-label="Exit" @click="goToDashboard">
      <NIcon size="20" :component="Logout" />
    </c-button>
  </c-tooltip>
</template>
