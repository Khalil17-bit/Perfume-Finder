import createMiddleware from 'next-intl/middleware';
import { NextRequest } from 'next/server';
import { routing } from './i18n/routing';
import { updateSession } from './lib/supabase/middleware';

const handleI18nRouting = createMiddleware(routing);

export default async function middleware(request: NextRequest) {
  const i18nResponse = handleI18nRouting(request);
  return await updateSession(request, i18nResponse);
}

export const config = {
  matcher: ['/', '/(ar|fr|en)/:path*'],
};
