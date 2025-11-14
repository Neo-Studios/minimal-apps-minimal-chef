'use client'

import React, { useState } from 'react'
import { Material3Button } from '@/components/ui/Material3Button'
import { Material3Card } from '@/components/ui/Material3Card'
import { Material3TextField } from '@/components/ui/Material3TextField'

export default function DesignShowcase() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')

  return (
    <div className="min-h-screen bg-m3-surface p-8">
      <div className="max-w-6xl mx-auto space-y-12">
        {/* Header */}
        <div className="text-center space-y-4">
          <h1 className="text-5xl font-normal text-m3-on-surface">
            Material 3 Expressive
          </h1>
          <p className="text-lg text-m3-on-surface-variant">
            Design System Showcase for Zest
          </p>
        </div>

        {/* Colors */}
        <section className="space-y-4">
          <h2 className="text-3xl font-semibold text-m3-on-surface">Colors</h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <div className="space-y-2">
              <div className="h-24 bg-m3-primary-main rounded-large shadow-elevation-2" />
              <p className="text-sm text-m3-on-surface-variant">Primary</p>
            </div>
            <div className="space-y-2">
              <div className="h-24 bg-m3-secondary-main rounded-large shadow-elevation-2" />
              <p className="text-sm text-m3-on-surface-variant">Secondary</p>
            </div>
            <div className="space-y-2">
              <div className="h-24 bg-m3-tertiary-main rounded-large shadow-elevation-2" />
              <p className="text-sm text-m3-on-surface-variant">Tertiary</p>
            </div>
            <div className="space-y-2">
              <div className="h-24 bg-m3-error rounded-large shadow-elevation-2" />
              <p className="text-sm text-m3-on-surface-variant">Error</p>
            </div>
          </div>
        </section>

        {/* Buttons */}
        <section className="space-y-4">
          <h2 className="text-3xl font-semibold text-m3-on-surface">Buttons</h2>
          <div className="flex flex-wrap gap-4">
            <Material3Button variant="filled">Filled</Material3Button>
            <Material3Button variant="outlined">Outlined</Material3Button>
            <Material3Button variant="text">Text</Material3Button>
            <Material3Button variant="elevated">Elevated</Material3Button>
            <Material3Button variant="tonal">Tonal</Material3Button>
          </div>
          <div className="flex flex-wrap gap-4">
            <Material3Button variant="filled" size="small">
              Small
            </Material3Button>
            <Material3Button variant="filled" size="medium">
              Medium
            </Material3Button>
            <Material3Button variant="filled" size="large">
              Large
            </Material3Button>
          </div>
          <div className="flex flex-wrap gap-4">
            <Material3Button
              variant="filled"
              icon={
                <svg
                  className="w-5 h-5"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M12 4v16m8-8H4"
                  />
                </svg>
              }
            >
              With Icon
            </Material3Button>
            <Material3Button variant="filled" disabled>
              Disabled
            </Material3Button>
          </div>
        </section>

        {/* Cards */}
        <section className="space-y-4">
          <h2 className="text-3xl font-semibold text-m3-on-surface">Cards</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <Material3Card variant="elevated">
              <div className="p-6 space-y-2">
                <h3 className="text-xl font-medium text-m3-on-surface">
                  Elevated Card
                </h3>
                <p className="text-m3-on-surface-variant">
                  Default card style with shadow elevation
                </p>
              </div>
            </Material3Card>
            <Material3Card variant="filled">
              <div className="p-6 space-y-2">
                <h3 className="text-xl font-medium text-m3-on-surface">
                  Filled Card
                </h3>
                <p className="text-m3-on-surface-variant">
                  Emphasized card with filled background
                </p>
              </div>
            </Material3Card>
            <Material3Card variant="outlined">
              <div className="p-6 space-y-2">
                <h3 className="text-xl font-medium text-m3-on-surface">
                  Outlined Card
                </h3>
                <p className="text-m3-on-surface-variant">
                  Subtle card with border outline
                </p>
              </div>
            </Material3Card>
          </div>
          <Material3Card variant="elevated" interactive>
            <div className="p-6 space-y-2">
              <h3 className="text-xl font-medium text-m3-on-surface">
                Interactive Card
              </h3>
              <p className="text-m3-on-surface-variant">
                Click me! This card has hover and active states.
              </p>
            </div>
          </Material3Card>
        </section>

        {/* Text Fields */}
        <section className="space-y-4">
          <h2 className="text-3xl font-semibold text-m3-on-surface">
            Text Fields
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 max-w-2xl">
            <Material3TextField
              label="Email"
              value={email}
              onChange={setEmail}
              type="email"
              placeholder="Enter your email"
              icon={
                <svg
                  className="w-5 h-5"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
                  />
                </svg>
              }
            />
            <Material3TextField
              label="Password"
              value={password}
              onChange={setPassword}
              type="password"
              placeholder="Enter your password"
              icon={
                <svg
                  className="w-5 h-5"
                  fill="none"
                  stroke="currentColor"
                  viewBox="0 0 24 24"
                >
                  <path
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth={2}
                    d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"
                  />
                </svg>
              }
            />
            <Material3TextField
              label="Error State"
              value=""
              onChange={() => {}}
              error
              helperText="This field is required"
            />
            <Material3TextField
              label="Disabled"
              value="Disabled field"
              onChange={() => {}}
              disabled
            />
          </div>
        </section>

        {/* Typography */}
        <section className="space-y-4">
          <h2 className="text-3xl font-semibold text-m3-on-surface">
            Typography
          </h2>
          <div className="space-y-2">
            <p className="text-[57px] leading-[64px] text-m3-on-surface">
              Display Large
            </p>
            <p className="text-[45px] leading-[52px] text-m3-on-surface">
              Display Medium
            </p>
            <p className="text-[36px] leading-[44px] text-m3-on-surface">
              Display Small
            </p>
            <p className="text-[32px] leading-[40px] text-m3-on-surface">
              Headline Large
            </p>
            <p className="text-[28px] leading-[36px] text-m3-on-surface">
              Headline Medium
            </p>
            <p className="text-[24px] leading-[32px] text-m3-on-surface">
              Headline Small
            </p>
            <p className="text-[22px] leading-[28px] font-medium text-m3-on-surface">
              Title Large
            </p>
            <p className="text-base leading-6 font-medium text-m3-on-surface">
              Title Medium
            </p>
            <p className="text-sm leading-5 font-medium text-m3-on-surface">
              Title Small
            </p>
            <p className="text-base leading-6 text-m3-on-surface">Body Large</p>
            <p className="text-sm leading-5 text-m3-on-surface">Body Medium</p>
            <p className="text-xs leading-4 text-m3-on-surface">Body Small</p>
          </div>
        </section>

        {/* Elevation */}
        <section className="space-y-4">
          <h2 className="text-3xl font-semibold text-m3-on-surface">
            Elevation
          </h2>
          <div className="grid grid-cols-2 md:grid-cols-5 gap-4">
            {[1, 2, 3, 4, 5].map((level) => (
              <div
                key={level}
                className={`h-32 bg-m3-surface-container rounded-large shadow-elevation-${level} flex items-center justify-center`}
              >
                <p className="text-m3-on-surface font-medium">Level {level}</p>
              </div>
            ))}
          </div>
        </section>

        {/* Spacing */}
        <section className="space-y-4">
          <h2 className="text-3xl font-semibold text-m3-on-surface">Spacing</h2>
          <div className="space-y-2">
            {[
              { name: 'xs', value: '4px' },
              { name: 'sm', value: '8px' },
              { name: 'md', value: '12px' },
              { name: 'lg', value: '16px' },
              { name: 'xl', value: '24px' },
              { name: '2xl', value: '32px' },
              { name: '3xl', value: '48px' },
            ].map((space) => (
              <div key={space.name} className="flex items-center gap-4">
                <div
                  className={`h-8 bg-m3-primary-main rounded`}
                  style={{ width: space.value }}
                />
                <p className="text-m3-on-surface-variant">
                  {space.name} - {space.value}
                </p>
              </div>
            ))}
          </div>
        </section>
      </div>
    </div>
  )
}
