import { registerBlockType } from '@wordpress/blocks';
import {
  InspectorControls,
  InnerBlocks,
  MediaUpload,
  MediaUploadCheck,
  RichText,
  URLInputButton,
  useBlockProps,
} from '@wordpress/block-editor';
import {
  Button,
  PanelBody,
  SelectControl,
  TextControl,
} from '@wordpress/components';
import { createElement as el, Fragment } from '@wordpress/element';
import domReady from '@wordpress/dom-ready';
import { __ } from '@wordpress/i18n';
import metadataHero from '../views/blocks/hero/block.json';
import metadataTextImage from '../views/blocks/text-image/block.json';
import metadataCta from '../views/blocks/cta/block.json';
import metadataAccordion from '../views/blocks/accordion/block.json';
import metadataAccordionItem from '../views/blocks/accordion-item/block.json';

const text = (tagName, label, value, onChange, placeholder = label) =>
  el(RichText, {
    tagName,
    value,
    onChange,
    placeholder,
    allowedFormats: ['core/bold', 'core/italic', 'core/link'],
  });

const ctaControls = (attributes, setAttributes) =>
  el(
    Fragment,
    {},
    el(TextControl, {
      label: __('Primary label', 'starter-theme'),
      value: attributes.primaryCtaLabel || '',
      onChange: (primaryCtaLabel) => setAttributes({ primaryCtaLabel }),
    }),
    el(URLInputButton, {
      url: attributes.primaryCtaUrl || '',
      onChange: (primaryCtaUrl) => setAttributes({ primaryCtaUrl }),
    }),
    el(TextControl, {
      label: __('Secondary label', 'starter-theme'),
      value: attributes.secondaryCtaLabel || '',
      onChange: (secondaryCtaLabel) => setAttributes({ secondaryCtaLabel }),
    }),
    el(URLInputButton, {
      url: attributes.secondaryCtaUrl || '',
      onChange: (secondaryCtaUrl) => setAttributes({ secondaryCtaUrl }),
    }),
  );

const imageControl = (attributes, setAttributes) =>
  el(
    MediaUploadCheck,
    {},
    el(MediaUpload, {
      allowedTypes: ['image'],
      value: attributes.imageId,
      onSelect: (image) =>
        setAttributes({
          imageId: image.id,
          imageUrl: image.url,
          imageAlt: image.alt || '',
        }),
      render: ({ open }) =>
        el(
          Button,
          { variant: 'secondary', onClick: open },
          attributes.imageUrl
            ? __('Replace image', 'starter-theme')
            : __('Select image', 'starter-theme'),
        ),
    }),
  );

const previewImage = (attributes) =>
  attributes.imageUrl
    ? el('img', {
        src: attributes.imageUrl,
        alt: attributes.imageAlt || '',
        style: { maxWidth: '100%', height: 'auto' },
      })
    : el(
        'div',
        { className: 'starter-block-placeholder' },
        __('Image', 'starter-theme'),
      );

domReady(() => {
  registerBlockType(metadataHero.name, {
    ...metadataHero,
    edit: ({ attributes, setAttributes }) =>
      el(
        'section',
        { ...useBlockProps({ className: 'starter-hero' }) },
        el(
          InspectorControls,
          {},
          el(
            PanelBody,
            { title: __('Settings', 'starter-theme') },
            el(SelectControl, {
              label: __('Alignment', 'starter-theme'),
              value: attributes.alignment,
              options: [
                { label: __('Left', 'starter-theme'), value: 'left' },
                { label: __('Center', 'starter-theme'), value: 'center' },
              ],
              onChange: (alignment) => setAttributes({ alignment }),
            }),
            el(SelectControl, {
              label: __('Variant', 'starter-theme'),
              value: attributes.variant,
              options: [
                { label: __('Default', 'starter-theme'), value: 'default' },
                { label: __('Muted', 'starter-theme'), value: 'muted' },
              ],
              onChange: (variant) => setAttributes({ variant }),
            }),
            imageControl(attributes, setAttributes),
          ),
        ),
        text(
          'p',
          __('Eyebrow', 'starter-theme'),
          attributes.eyebrow,
          (eyebrow) => setAttributes({ eyebrow }),
        ),
        text('h2', __('Title', 'starter-theme'), attributes.title, (title) =>
          setAttributes({ title }),
        ),
        text('p', __('Text', 'starter-theme'), attributes.text, (value) =>
          setAttributes({ text: value }),
        ),
        ctaControls(attributes, setAttributes),
        previewImage(attributes),
      ),
    save: () => null,
  });

  registerBlockType(metadataTextImage.name, {
    ...metadataTextImage,
    edit: ({ attributes, setAttributes }) =>
      el(
        'section',
        { ...useBlockProps({ className: 'starter-text-image' }) },
        el(
          InspectorControls,
          {},
          el(
            PanelBody,
            { title: __('Settings', 'starter-theme') },
            el(SelectControl, {
              label: __('Image position', 'starter-theme'),
              value: attributes.imagePosition,
              options: [
                { label: __('Right', 'starter-theme'), value: 'right' },
                { label: __('Left', 'starter-theme'), value: 'left' },
              ],
              onChange: (imagePosition) => setAttributes({ imagePosition }),
            }),
            el(SelectControl, {
              label: __('Variant', 'starter-theme'),
              value: attributes.variant,
              options: [
                { label: __('Default', 'starter-theme'), value: 'default' },
                { label: __('Muted', 'starter-theme'), value: 'muted' },
              ],
              onChange: (variant) => setAttributes({ variant }),
            }),
            imageControl(attributes, setAttributes),
          ),
        ),
        text('h2', __('Title', 'starter-theme'), attributes.title, (title) =>
          setAttributes({ title }),
        ),
        text('p', __('Text', 'starter-theme'), attributes.text, (value) =>
          setAttributes({ text: value }),
        ),
        el(TextControl, {
          label: __('CTA label', 'starter-theme'),
          value: attributes.ctaLabel || '',
          onChange: (ctaLabel) => setAttributes({ ctaLabel }),
        }),
        el(URLInputButton, {
          url: attributes.ctaUrl || '',
          onChange: (ctaUrl) => setAttributes({ ctaUrl }),
        }),
        previewImage(attributes),
      ),
    save: () => null,
  });

  registerBlockType(metadataCta.name, {
    ...metadataCta,
    edit: ({ attributes, setAttributes }) =>
      el(
        'section',
        { ...useBlockProps({ className: 'starter-cta' }) },
        el(
          InspectorControls,
          {},
          el(
            PanelBody,
            { title: __('Settings', 'starter-theme') },
            el(SelectControl, {
              label: __('Variant', 'starter-theme'),
              value: attributes.variant,
              options: [
                { label: __('Default', 'starter-theme'), value: 'default' },
                { label: __('Muted', 'starter-theme'), value: 'muted' },
              ],
              onChange: (variant) => setAttributes({ variant }),
            }),
          ),
        ),
        text('h2', __('Title', 'starter-theme'), attributes.title, (title) =>
          setAttributes({ title }),
        ),
        text('p', __('Text', 'starter-theme'), attributes.text, (value) =>
          setAttributes({ text: value }),
        ),
        ctaControls(attributes, setAttributes),
      ),
    save: () => null,
  });

  registerBlockType(metadataAccordion.name, {
    ...metadataAccordion,
    edit: ({ attributes, setAttributes }) =>
      el(
        'section',
        { ...useBlockProps({ className: 'starter-accordion' }) },
        text('h2', __('Title', 'starter-theme'), attributes.title, (title) =>
          setAttributes({ title }),
        ),
        el(InnerBlocks, {
          allowedBlocks: ['starter/accordion-item'],
          template: [
            [
              'starter/accordion-item',
              { question: __('Question', 'starter-theme') },
            ],
          ],
        }),
      ),
    save: () => el(InnerBlocks.Content),
  });

  registerBlockType(metadataAccordionItem.name, {
    ...metadataAccordionItem,
    edit: ({ attributes, setAttributes }) =>
      el(
        'div',
        { ...useBlockProps({ className: 'starter-accordion-item' }) },
        text(
          'h3',
          __('Question', 'starter-theme'),
          attributes.question,
          (question) => setAttributes({ question }),
        ),
        el(InnerBlocks, {
          template: [
            ['core/paragraph', { placeholder: __('Answer', 'starter-theme') }],
          ],
        }),
      ),
    save: () => el(InnerBlocks.Content),
  });
});
