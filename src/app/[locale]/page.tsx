import { unstable_setRequestLocale } from 'next-intl/server';
import LavaLandingClient from '@/components/landing/LavaLandingClient';

type Props = {
  params: { locale: string };
};

export default function LandingPage({ params: { locale } }: Props) {
  unstable_setRequestLocale(locale);

  return <LavaLandingClient />;
}
