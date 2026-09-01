// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	site: 'https://kblivesolutions.github.io',
	base: '/param8',
	integrations: [
		starlight({
			title: '',
			logo: { src: './src/assets/logo.svg' },
			social: [{ icon: 'github', label: 'GitHub', href: 'https://github.com/KBLiveSolutions/param8' }],
			components: {
					Header: './src/components/Header.astro',
					Sidebar: './src/components/Sidebar.astro',
				},
				customCss: ['./src/styles/custom.css'],
			sidebar: [
				{
					label: 'Getting Started',
					items: [
						{ label: 'Overview', slug: 'docs/overview' },
						{ label: 'Quick Start', slug: 'docs/quick-start' },
					],
				},
				{
					label: 'User Guide',
					items: [
						{ label: 'Presets', slug: 'docs/presets' },
						{ label: 'Mixer Mode', slug: 'docs/mixer-mode' },
						{ label: 'Device Mode', slug: 'docs/device-mode' },
						{ label: 'Latch & Revert', slug: 'docs/latch-revert' },
					],
				},
				{
					label: 'Configuration',
					items: [
						{ label: 'Editor', slug: 'docs/editor' },
						{ label: 'Display Layouts', slug: 'docs/layouts' },
					],
				},
				{
					label: 'Reference',
					items: [
						{ label: 'MIDI Map', slug: 'docs/midi-map' },
						{ label: 'SysEx Protocol', slug: 'docs/sysex' },
					],
				},
			],
		}),
	],
});
